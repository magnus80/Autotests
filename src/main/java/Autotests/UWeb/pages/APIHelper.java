package Autotests.UWeb.pages;

import Autotest.common.properties.PropertyLoaderStatic;
import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import org.apache.http.client.fluent.Content;
import org.apache.http.client.fluent.Request;
import org.openqa.selenium.By;
import ru.yandex.qatools.properties.annotations.Property;
import ru.yandex.qatools.properties.annotations.Resource;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Resource.Classpath("./UWeb/Pages/API_REST.properties")

public class APIHelper extends Helper_my {

    static {
        PropertyLoaderStatic.populate(APIHelper.class);
    }

    @Property("Stand")
    //@Use(ByConverter.class)
    private static By stand;

    /**
     * Метод получения авторизационного токена
     *
     * @return
     * @throws IOException
     */
    public String auth(String login, String password) throws IOException {
        String js = Request.Get("http://usssfttb-test.vimpelcom.ru:22001/api/1.0/auth?login=" + login + "&password=" + password)
                .execute().returnContent().asString();
        JsonElement parsed = new JsonParser().parse(js);
        return parsed.getAsJsonObject().get("token").toString().replaceAll("\"", "");
    }

    /**
     * метод получения доп. балансов препейда
     *
     * @return
     * @throws IOException
     */
    public List<String> prepaidAddBalance(String login, String password, String ctn) throws IOException {
        Request get = Request.Get("http://usssfttb-test.vimpelcom.ru:22001/api/1.0/info/prepaidAddBalance?ctn=" + ctn);
        get.setHeader("Connection", "keep-alive");
        get.setHeader("Content-Type", "application/json");
        get.setHeader("User-Agent", "Apache-HttpClient/4.2.3");
        String DOMAIN = "usssfttb-test.vimpelcom.ru";
        get.setHeader("Cookie", "$Version=\"1\"; token=\"" + auth(login, password) + "\"; $Path=\"\"; $Domain=\"" + DOMAIN + "\"");
        String json = get.execute().returnContent().asString();
        JsonObject parsed = new JsonParser().parse(json).getAsJsonObject();
        List<String> keys = parsed.entrySet().stream().map(i -> i.getKey()).collect(Collectors.toCollection(ArrayList::new));
        keys.remove(0);
        keys.forEach(System.out::println);
        //String res = keys.toArray().toString();
        return keys;
    }

    /**
     * метод получения списка услуг
     *
     * @return
     * @throws IOException
     */
    public List<String> serviceList(String login, String password, String ctn) throws IOException {
        Request get = Request.Get("http://usssfttb-test.vimpelcom.ru:22001/api/1.0/info/prepaidAddBalance?ctn=" + ctn);
        get.setHeader("Connection", "keep-alive");
        get.setHeader("Content-Type", "application/json");
        get.setHeader("User-Agent", "Apache-HttpClient/4.2.3");
        String DOMAIN = "usssfttb-test.vimpelcom.ru";
        get.setHeader("Cookie", "$Version=\"1\"; token=\"" + auth(login, password) + "\"; $Path=\"\"; $Domain=\"" + DOMAIN + "\"");
        String json = get.execute().returnContent().asString();
        JsonObject parsed = new JsonParser().parse(json).getAsJsonObject();
        List<String> keys = parsed.entrySet().stream().map(i -> i.getKey()).collect(Collectors.toCollection(ArrayList::new));
        keys.remove(0);
        keys.forEach(System.out::println);
        //String res = keys.toArray().toString();
        return keys;
    }

    /**
     * метод получения подписок
     *
     * @param login
     * @param password
     * @param ctn
     * @return
     * @throws IOException
     */

    public List<String> subscriptions(String login, String password, String ctn) throws IOException {
        Request get = Request.Get("http://usssfttb-test.vimpelcom.ru:22001/api/1.0/info/prepaidAddBalance?ctn=" + ctn);
   /* get.setHeader("Connection", "keep-alive");
    get.setHeader("Content-Type", "application/json");
    get.setHeader("User-Agent", "Apache-HttpClient/4.2.3");*/
        String DOMAIN = "usssfttb-test.vimpelcom.ru";
        get.setHeader("Cookie", "$Version=\"1\"; token=\"" + auth(login, password) + "\"; $Path=\"\"; $Domain=\"" + DOMAIN + "\"");
        String json = get.execute().returnContent().asString();
        JsonObject parsed = new JsonParser().parse(json).getAsJsonObject();
        List<String> keys = parsed.entrySet().stream().map(i -> i.getKey()).collect(Collectors.toCollection(ArrayList::new));
        keys.remove(0);
        keys.forEach(System.out::println);
        //String res = keys.toArray().toString();
        return keys;
    }

}
