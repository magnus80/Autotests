package Autotests.UWeb.pages;

import Autotest.common.converters.ByConverter;
import Autotest.common.properties.PropertyLoaderStatic;
import org.openqa.selenium.By;
import ru.yandex.qatools.properties.annotations.Property;
import ru.yandex.qatools.properties.annotations.Resource;
import ru.yandex.qatools.properties.annotations.Use;

/**
 * @author VRakshin
 */
@Resource.Classpath("./UWeb/Pages/Page_Login.properties")
public class Page_Login extends Helper_my {

    static {
        PropertyLoaderStatic.populate(Page_Login.class);
    }

    @Property("Default_URL")
    private static String URL;

    @Property("Login_field")
    @Use(ByConverter.class)
    private static By LOGIN_FIELD;

    @Property("Password_field")
    @Use(ByConverter.class)
    private static By PASS_FIELD;

    @Property("Enter_button")
    @Use(ByConverter.class)
    private static By ENTER_BUTTON;

    /**
     * Открытие страницы ввода логина и пароля
     */
    public void openLoginPage() {
        open(URL);
    }

    /**
     * Ввод логина, пароля и нажатие кнопки Войти
     *
     * @param login
     * @param password
     */
    public void login(String login, String password) {
        fillText(LOGIN_FIELD, login);
        fillText(PASS_FIELD, password);
        $(ENTER_BUTTON).click();
        waitUntilAjaxFinished();
    }

}