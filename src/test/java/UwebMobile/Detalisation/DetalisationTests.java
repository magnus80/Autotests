package UwebMobile.Detalisation;

import Autotest.common.properties.ExcelPropertyProviderStatic;
import Autotest.common.properties.FromSheet;
import Autotest.common.properties.PropertyLoaderStatic;
import Autotest.common.properties.WithStatic;
import Autotest.common.supers.BaseScenario;
import Autotests.UWeb.pages.Page_Login;
import Autotests.UWeb.pages.Page_Profile;
import org.testng.annotations.Test;
import ru.yandex.qatools.allure.annotations.Features;
import ru.yandex.qatools.allure.annotations.Stories;
import ru.yandex.qatools.allure.annotations.Title;
import ru.yandex.qatools.properties.annotations.Property;
import ru.yandex.qatools.properties.annotations.Resource;

@Resource.Classpath("Properties.xlsx")
@WithStatic(ExcelPropertyProviderStatic.class)
@FromSheet.Common("Detalisation Prepaid")
public class DetalisationTests extends BaseScenario {

    static {
        PropertyLoaderStatic.populate(DetalisationTests.class);
    }

    public DetalisationSteps detSteps = new DetalisationSteps();

    @Property("Login_Det_Prepaid")
    private static String LOGIN;
    @Property("Password_Det_Prepaid")
    private static String PASSWORD;

    public Page_Login pLogin = new Page_Login();
    public Page_Profile pProfile = new Page_Profile();

    @Title("Финансы и детализация")
    @Features("Просмотр пользователем виджета Детализация")
    @Stories({"Sanity", "Финансы и детализация"})
    @Test(groups = {"All_tests", "UWebtest"})
    public void test_DetalisationWidget() throws Exception {
        //System.out.println(LOGIN);
        detSteps.login(LOGIN, PASSWORD);

        pProfile.logOut();
    }
}
