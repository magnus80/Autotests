package UwebMobile.Messages;

import Autotest.common.properties.ExcelPropertyProviderStatic;
import Autotest.common.properties.FromSheet;
import Autotest.common.properties.PropertyLoaderStatic;
import Autotest.common.properties.WithStatic;
import Autotest.common.supers.BaseScenario;
import Autotests.UWeb.pages.Page_Login;
import Autotests.UWeb.pages.Page_Profile;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import org.apache.http.client.fluent.Content;
import org.apache.http.client.fluent.Request;
import org.apache.http.client.fluent.Response;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;
import ru.yandex.qatools.allure.annotations.Features;
import ru.yandex.qatools.allure.annotations.Stories;
import ru.yandex.qatools.allure.annotations.Title;
import ru.yandex.qatools.properties.annotations.Property;
import ru.yandex.qatools.properties.annotations.Resource;

/**
 * @author VRakshin
 */
@Resource.Classpath("Properties.xlsx")
@WithStatic(ExcelPropertyProviderStatic.class)
@FromSheet.Common("General Information")
public class MessagesTests extends BaseScenario {
    static {
        PropertyLoaderStatic.populate(MessagesTests.class);
    }

    public MessagesSteps messagesSteps = new MessagesSteps();

    @Property("Login_messages")
    private static String LOGIN;
    @Property("Password_messages")
    private static String PASSWORD;

    public Page_Login pLogin = new Page_Login();
    public Page_Profile pProfile = new Page_Profile();

    @Title("Сообщения")
    @Features("Проверка сообщений")
    @Stories({"Sanity", "Сообщения"})
    @Test(groups = {"All_tests", "UWebtest"})
    public void test_Messages() throws Exception {
        messagesSteps.login(LOGIN, PASSWORD);
        messagesSteps.gotoMessages();
        messagesSteps.logout();
    }


    @Title("Сообщения")
    @Features("Проверка заявок")
    @Stories({"Sanity", "Сообщения"})
    @Test(groups = {"All_tests", "UWebtest"})
    public void test_Requests() throws Exception {
        messagesSteps.login(LOGIN, PASSWORD);
        messagesSteps.gotoMessages();
        messagesSteps.logout();
    }


    @AfterClass(alwaysRun = true, groups = {"All_tests", "UWebtest"})
    public void deleteAfterAllTests() throws Exception {
/*        messagesSteps.deleteFromBDComverse(DBD_PATH_1);
        messagesSteps.deleteFromBDOdscmv(DBD_PATH_2);
        messagesSteps.deleteFromBDHistorical(DBD_PATH_3);*/
        System.out.println("\ndeleteAfterAllTests - OK\n");
    }

    @BeforeClass(alwaysRun = true, groups = {"Agregation", "Agregation_oo", "trai__ning"})
    public void deleteBeforeAllTests() throws Exception {
/*        messagesSteps.deleteFromBDComverse(DBD_PATH_1);
        messagesSteps.deleteFromBDOdscmv(DBD_PATH_2);
        messagesSteps.deleteFromBDHistorical(DBD_PATH_3);*/
        System.out.println("\ndeleteBeforeAllTests - OK\n");
    }
}