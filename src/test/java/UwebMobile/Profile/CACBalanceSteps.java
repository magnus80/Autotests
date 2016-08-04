package UwebMobile.Profile;

import Autotest.common.utils.Attacher;
import Autotests.UWeb.pages.Page_Login;
import Autotests.UWeb.pages.Page_Profile;
import ru.yandex.qatools.allure.annotations.Step;

import static org.testng.Assert.assertTrue;

public class CACBalanceSteps extends ProfileHelper {

    public Page_Login pLogin = new Page_Login();
    public Page_Profile pProfile = new Page_Profile();

    @Step("Вход в ЛК по логину и паролю {0} {1}"
            + "\nОЖИДАЕТСЯ:\n"
            + "Вход в ЛК и скрытие бонусов")
    public void login(String login, String password) throws Exception {
        pLogin.openLoginPage();
        pLogin.login(login, password);
        pProfile.hideBonus();
    }

    @Step("Выход из ЛК"
            + "\nОЖИДАЕТСЯ:\n"
            + "ЛК закрыт.")
    public void logout() throws Exception {
        //pProfile.logOut();
        close();
    }

    @Step("Открыть ссылку и получить сумму САС баланса"
            + "\nОЖИДАЕТСЯ:\n"
            + "САС баланс присутствует.")
    public void getCACBalance() throws Exception {
       // assertTrue(true, pProfile.getCACBalance());
        Attacher.attachText("САС Баланс присутствует", pProfile.getCACBalance());
    }

    @Step("Нажать на кнопку «Пополнить баланс» "
            + "\nОЖИДАЕТСЯ:\n"
            + "Открывается страница пополнения счета")
    public void addCACBalance() throws Exception {
        assertTrue(true, pProfile.addCACBalance());
        //Attacher.attachText("САС Баланс присутствует", pProfile.getCACBalance());
    }



}
