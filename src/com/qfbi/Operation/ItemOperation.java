package com.qfbi.Operation;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.action.search.SearchType;
import org.elasticsearch.client.Client;
import org.elasticsearch.client.transport.TransportClient;
import org.elasticsearch.common.settings.ImmutableSettings;
import org.elasticsearch.common.settings.Settings;
import org.elasticsearch.common.transport.InetSocketTransportAddress;
import org.elasticsearch.common.unit.TimeValue;
import org.elasticsearch.index.query.QueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.SearchHit;

/**
 * 
 * @author Administrator 产品库插入ES
 * 
 */
public class ItemOperation {
	/**
	 * 定义Java Client
	 */
	public static Client client;

	/**
	 * 初始化Client 192.10.20.7
	 */
	@SuppressWarnings("resource")
	public static void init() {
		Settings settings = ImmutableSettings.settingsBuilder()
				.put("cluster.name", "elasticsearch")
				// 探测集群中机器状态
				.put("client.transport.sniff", true).build();
		client = new TransportClient(settings)
				.addTransportAddress(new InetSocketTransportAddress(
						"192.10.20.7", 9300));
		System.out.println("init successfuly");
	}

	/**
	 * 搜索功能，关键字搜索
	 * 
	 * @param query
	 * @return
	 */
	public static JSONArray search(String query) {
		int i = 0;
		JSONArray jsonArray = new JSONArray();
		QueryBuilder qb = QueryBuilders.multiMatchQuery(query, "title",
				"item_desc");
		SearchResponse scrollResp = client
				.prepareSearch("iteminfo")
				.setTypes("shop")
				.setSearchType(SearchType.DEFAULT)
				.setScroll(new TimeValue(60000))
				// .addSort("create_time", SortOrder.DESC)
				.addHighlightedField("item_desc")
				.setHighlighterPreTags("<span style=\"color:red\">")
				.setHighlighterPostTags("</span>").setQuery(qb).setSize(50)
				.execute().actionGet(); // 100 hits per shard will be returned
										// for each scroll
		while (true) {
			scrollResp = client.prepareSearchScroll(scrollResp.getScrollId())
					.setScroll(new TimeValue(600000)).execute().actionGet();
			if (scrollResp.getHits().getHits().length == 0) {
				System.out.println("break");
				break;
			}
			for (SearchHit hit : scrollResp.getHits()) {
				JSONObject jsonObject = JSONObject.fromObject(hit
						.getSourceAsString());
				jsonArray.add(jsonObject);
				i++;
				if (i >= 50) {
					break;
				}
			}
			if (i >= 50) {
				break;
			}
			// Break condition: No hits are returned
			if (scrollResp.getHits().getHits().length == 0) {
				break;
			}
		}
		return jsonArray;
	}
	
	public static void insert(){
		
	}
	public static void close() {
		client.close();
	}
}