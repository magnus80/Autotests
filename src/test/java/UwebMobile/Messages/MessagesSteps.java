package UwebMobile.Messages;

import Autotest.common.utils.Attacher;
import Autotests.UWeb.pages.Page_Login;
import Autotests.UWeb.pages.Page_Messages;
import Autotests.UWeb.pages.Page_Profile;
import Autotests.UWeb.pages.APIHelper;
import com.codeborne.selenide.WebDriverRunner;
import ru.yandex.qatools.allure.annotations.Step;

import static org.testng.Assert.assertTrue;

/**
 * @author VRakshin
 */
public class MessagesSteps extends MessagesHelper {

    public Page_Login pLogin = new Page_Login();
    public Page_Profile pProfile = new Page_Profile();
    public Page_Messages pMessages = new Page_Messages();
    public APIHelper help=new APIHelper();

    String balance = "";

    @Step("Взятие информации из БД {0}"
            + "\nОЖИДАЕТСЯ:\n"
            + "получили инфу из БД")
    public void step0(String login) throws Exception {
        getFromDB(login);
        System.out.println(balance);
        Attacher.attachText("Результат запроса: ", balance);
    }

    @Step("Вход в ЛК по логину и паролю {0} {1}"
            + "\nОЖИДАЕТСЯ:\n"
            + "Вход в ЛК и скрытие бонусов")
    public void login(String login, String password) throws Exception {
        pLogin.openLoginPage();
        pLogin.login(login, password);
        pProfile.hideBonus();
    }

    @Step("Переход в Сообщения"
            + "\nОЖИДАЕТСЯ:\n"
            + "Переход на вкладку Сообщения"
            + "отображены Завки и Уведомления")
    public void gotoMessages() throws Exception {
        pProfile.gotoMessages();
        assertTrue(pMessages.isNoticesDisplayed(), "");
        assertTrue(pMessages.isRequestsDisplayed(), "");
    }

    @Step("Сравнение баланса на профиле и в БД"
            + "\nОЖИДАЕТСЯ:\n"
            + "Балансы равны.")
    public void step2(String error_message) throws Exception {
        String balance_ = pProfile.getBalanceMoney().replace(",", ".");
        System.out.println("balance=" + balance_);
        assertTrue(new Float(balance_) > 0, error_message);
        assertTrue(balance_.contains(balance), error_message);
        Attacher.attachText("Баланс: ", balance);
    }

    @Step("Выход из ЛК"
            + "\nОЖИДАЕТСЯ:\n"
            + "ЛК закрыт.")
    public void logout() throws Exception {
        pProfile.logOut();
        WebDriverRunner.getWebDriver().manage().deleteAllCookies();
    }
}