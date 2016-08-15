package UwebMobile.Profile;

import Autotest.common.properties.ExcelPropertyProviderStatic;
import Autotest.common.properties.FromSheet;
import Autotest.common.properties.PropertyLoaderStatic;
import Autotest.common.properties.WithStatic;
import Autotest.common.supers.BaseScenario;
import org.testng.annotations.Test;
import ru.yandex.qatools.allure.annotations.Description;
import ru.yandex.qatools.allure.annotations.Features;
import ru.yandex.qatools.allure.annotations.Stories;
import ru.yandex.qatools.allure.annotations.Title;
import ru.yandex.qatools.properties.annotations.Property;
import ru.yandex.qatools.properties.annotations.Resource;

import static com.codeborne.selenide.Selenide.close;

@Resource.Classpath("Properties.xlsx")
@WithStatic(ExcelPropertyProviderStatic.class)
@FromSheet.Common("Profile")

public class BillInfoTests extends BaseScenario {

    static {
        PropertyLoaderStatic.populate(UwebMobile.Profile.BillInfoTests.class);
    }

    public BillInfoSteps billInfoSteps = new BillInfoSteps();

    /*public static String black= "rgba(40, 40, 40, 1)";
    public static String red = "rgba(179,23,54,1)";*/

    @Property("Password")
    private static String PASSWORD;
    @Property("Login_PP_Prepaid")
    private static String LOGIN_RED;
    @Property("Login_services")
    private static String LOGIN_BLACK;
    @Property("CTN_PP_PREPAID")
    private static String CTN_PP_PREPAID;
    @Property("black")
    private static String black;
    @Property("red")
    private static String red;

    @Title("Профиль")
    @Description("Проверка отображения балансов")
    @Features("Получение инфо о состоянии счёта")
    @Stories({"Sanity", "Профиль"})
    @Test(groups = {"All_tests", "UWebtest"})
    public void test_BillsInfo() throws Exception {
        billInfoSteps.login(LOGIN_BLACK, PASSWORD);
        billInfoSteps.getColors(black);
        billInfoSteps.logout();
        billInfoSteps.login(LOGIN_RED, PASSWORD);
        billInfoSteps.getColors(red);
        billInfoSteps.getAutooplata();
        close();
    }
}
