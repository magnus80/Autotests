package UwebMobile.Profile;

import Autotest.common.properties.PropertyLoaderStatic;
import Autotest.common.supers.BaseScenario;
import org.testng.annotations.Test;
import ru.yandex.qatools.allure.annotations.Features;
import ru.yandex.qatools.allure.annotations.Stories;
import ru.yandex.qatools.allure.annotations.Title;
import ru.yandex.qatools.properties.annotations.Property;

import static com.codeborne.selenide.Selenide.close;

public class ManageServicesеTests extends BaseScenario {

    static {
        PropertyLoaderStatic.populate(ManageServicesSteps.class);
    }

    public ManageServicesSteps servicesSteps =new ManageServicesSteps();

    @Property("Password")
    private static String PASSWORD;
    @Property("Login_services")
    private static String LOGIN_SERVICES;
    @Property("CTN_services")
    private static String CTN_SERVICES;

    @Title("Профиль")
    @Features("Управление услугами на профиле")
    @Stories({"Sanity", "Профиль"})
    @Test(groups = {"All_tests", "UWebtest"})
    public void test_profileManageServices() throws Exception {
        servicesSteps.login(LOGIN_SERVICES,PASSWORD);
        servicesSteps.getServiceList(LOGIN_SERVICES,PASSWORD,CTN_SERVICES);
        servicesSteps.logout();
        close();
    }


}
