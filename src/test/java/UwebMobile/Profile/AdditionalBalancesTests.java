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

public class AdditionalBalancesTests extends BaseScenario {

    static {
        PropertyLoaderStatic.populate(AdditionalBalancesTests.class);
    }

    public AdditionalBalancesSteps abSteps=new AdditionalBalancesSteps();

    @Property("Password")
    private static String PASSWORD;
    @Property("Login_Add_Bal")
    private static String LOGIN_ADD_BAL;
    @Property("Ctn_Add_Bal")
    private static String CTN_ADD_BAL;
    @Property("Login_PP_Prepaid")
    private static String LOGIN_PREPAID;


    @Title("Профиль")
    @Features("Получение инфо о доп. балансах")
    @Stories({"Sanity", "Профиль"})
    @Test(groups = {"All_tests", "UWebtest"})
    public void test_getAdditionalBalances() throws Exception {
        abSteps.login(LOGIN_ADD_BAL,PASSWORD);
        abSteps.apiAddBalances(LOGIN_ADD_BAL,PASSWORD,CTN_ADD_BAL);
        abSteps.addBalancesLC();
        abSteps.logout();
        abSteps.login(LOGIN_PREPAID,PASSWORD);
        abSteps.logout();
    }

}
