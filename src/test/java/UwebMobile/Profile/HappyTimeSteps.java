package UwebMobile.Profile;

import Autotests.UWeb.pages.Helper_my;
import Autotests.UWeb.pages.Page_Login;
import Autotests.UWeb.pages.Page_Profile;
import ru.yandex.qatools.allure.annotations.Step;

public class HappyTimeSteps extends ProfileHelper {

    public Page_Login pLogin = new Page_Login();
    public Page_Profile pProfile = new Page_Profile();

    @Step("Вход в ЛК по логину и паролю {0} {1}"
            + "\nОЖИДАЕТСЯ:\n"
            + "Вход в ЛК, скрытие бонусов, Блок Счастливого времени в наличии")
    public void login(String login, String password) throws Exception {
        pLogin.openLoginPage();
        pLogin.login(login, password);
        pProfile.hideBonus();
        pProfile.isHappyTimeBlockDisplayed();
    }

    @Step("Выход из ЛК"
            + "\nОЖИДАЕТСЯ:\n"
            + "ЛК закрыт.")
    public void logout() throws Exception {
        pProfile.logOut();
    }

    @Step("Перевод бонусов другому абоненту"
            + "\nОЖИДАЕТСЯ:\n"
            + "Сообщение 'Нет бонусных рублей'.")
    public void noHappyTimeTransfer() throws Exception {
        pProfile.noTransferBonusesLink();
    }

    @Step("Сообщение об отправке запроса на перевод бонусов"
            + "\nОЖИДАЕТСЯ:\n"
            + "Текст корректный.")
    public void happyTimeTransferSucceceful() throws Exception {
        pProfile.transferBonusesApprove();
    }

    @Step("Перевод бонусов другому абоненту"
            + "\nОЖИДАЕТСЯ:\n"
            + "Запрос успешно отправлен.")
    public void happyTimeTransfer() throws Exception {
        pProfile.transferBonusesBlock();
    }



}
