package UwebMobile.Messages;

import Autotest.common.utils.DbUtils.OracleConnection;
import Autotest.common.utils.DbUtils.ResultQuery;
import Autotests.UWeb.Utils.BDHelper;
import Autotests.UWeb.pages.Helper_my;
import Autotests.UWeb.pages.Page_Login;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import org.apache.http.client.fluent.Request;

import java.io.IOException;

/**
 * @author VRakshin
 */
public class MessagesHelper extends Helper_my {

    Helper_my helper = new Helper_my();
    //Page_Main pageMain = new Page_Main();
    Page_Login pageLogin = new Page_Login();
    /* Table_Detalisation table = new Table_Detalisation();
     Page_Detalisation pageDetal = new Page_Detalisation();
     Page_Reference pageRef = new Page_Reference();
     Page_Returns pageRet = new Page_Returns();*/
    BDHelper bd = new BDHelper();
    int num_tr = 10;


    public static int getPeriodLast(String period) throws NumberFormatException {
        return new Integer(period.split("-")[1]);
    }

    public static int getPeriodFirst(String period) throws NumberFormatException {
        return new Integer(period.split("-")[0]);
    }

    public static String getFromDB(String login) throws Exception {
        String bal = "";
        OracleConnection oc = new OracleConnection("chaldean.ftst3.fttb.corbina.net", "1521", "billuss", "uss_test", "tset_ssu");
        ResultQuery res = oc.executeQuery("select (c_payed - c_uses) as balance from inac.contracts join inac.logins on l_contract = c_id where l_login = '" + login + "'");
        int num = res.getResultAsIs().findColumn("balance");
        res.getResultAsIs().first();
        bal = res.getResultAsIs().getString(num);
        oc.close();
        return bal;
    }

    public String serviceActivateSysToken(String host, String port,String ctn,String hash) throws IOException {
        String json = Request.Put(host + ":" + port + "/api/2.0/request/list?ctn="+ctn+"&serviceName=FREEM_200&hash="+hash)
                .execute().returnContent().asString();
        JsonElement parsed = new JsonParser().parse(json);
        return parsed.getAsJsonObject().get("meta").getAsJsonObject().get("status").toString();
    }

}