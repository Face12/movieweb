/**
 * 
 */
package se.face.movieweb.service;

import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * @author Samuel
 *
 */
@Service
public class MovieServiceImpl implements MovieService {
	private static final String hostAddress = "http://localhost:8080/moviews-web";
	private static final String searchPath = "/movies/search?query={query}";
	private static final String getPath = "/movies/{id}";
	
	@Override
	public Map<String, Object> searchMoviesByTitle(String title) {
		try (CloseableHttpClient client = createClient()) {
			HttpGet get = new HttpGet(
					hostAddress+searchPath.replace("{query}", urlEncode(title)));
			return executeForMap(client, get); 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public Map<String, Object> getMovieById(int id) {
		try (CloseableHttpClient client = createClient()) {
			HttpGet get = new HttpGet(
					hostAddress+getPath.replace("{id}", urlEncode(String.valueOf(id))));
			return executeForMap(client, get);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	private HashMap<String, Object> executeForMap(CloseableHttpClient client, HttpGet get) throws Exception {
		ObjectMapper objectMapper = new ObjectMapper();
		CloseableHttpResponse response = client.execute(get);
		if (response.getStatusLine().getStatusCode() / 100 == 2){
			HttpEntity entity = response.getEntity();
							
			HashMap<String,Object> movies = objectMapper.readValue(entity.getContent(), 
					new TypeReference<HashMap<String,Object>>(){});
			
			return movies;
		}
		else{
			throw new RuntimeException("Error server returned status: "+response.getStatusLine());
		}
	}

	private CloseableHttpClient createClient() {
		CloseableHttpClient client = HttpClientBuilder
			.create()
			.build();
		return client;
	}

	private String urlEncode(String string) {
		try {
			String encoded = URLEncoder.encode(string, "UTF-8");
			return encoded;
		} catch (Exception e) {
			throw new IllegalStateException(e);
		}
	}
}
