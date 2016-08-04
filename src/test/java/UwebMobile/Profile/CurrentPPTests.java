package UwebMobile.Profile;

import Autotest.common.properties.ExcelPropertyProviderStatic;
import Autotest.common.properties.FromSheet;
import Autotest.common.properties.PropertyLoaderStatic;
import Autotest.common.properties.WithStatic;
import Autotest.common.supers.BaseScenario;
import org.testng.annotations.Test;
import ru.yandex.qatools.allure.annotations.Features;
import ru.yandex.qatools.allure.annotations.Stories;
import ru.yandex.qatools.allure.annotations.Title;
import ru.yandex.qatools.properties.annotations.Property;
import ru.yandex.qatools.properties.annotations.Resource;

@Resource.Classpath("Properties.xlsx")
@WithStatic(ExcelPropertyProviderStatic.class)
@FromSheet.Common("Profile")

public class CurrentPPTests extends BaseScenario{

    static {
        PropertyLoaderStatic.populate(CurrentPPTests.class);
    }

    public CurrentPPSteps ppSteps=new CurrentPPSteps();

    @Property("Password")
    private static String PASSWORD;
    @Property("Login_PP_Prepaid")
    private static String LOGIN_PREPAID;
    @Property("Login_PP_Postpaid")
    private static String LOGIN_POSTPAID;

    @Title("Профиль")
    @Features("Получение информации о текущем ТП")
    @Stories({"Sanity", "Профиль"})
    @Test(groups = {"All_tests", "UWebtest"})
    public void test_getCurrentPP() throws Exception {
        ppSteps.login(LOGIN_PREPAID, PASSWORD);
        ppSteps.openedProfile();
        ppSteps.goToCurrentPP();
        ppSteps.logOutFromCurrentPP();
        ppSteps.login(LOGIN_POSTPAID, PASSWORD);
        ppSteps.openedProfile();
        ppSteps.goToCurrentPP();
        ppSteps.logOutFromCurrentPP();
    }

}
