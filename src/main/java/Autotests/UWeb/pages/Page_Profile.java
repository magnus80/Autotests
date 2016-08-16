package Autotests.UWeb.pages;

import Autotest.common.converters.ByConverter;
import Autotest.common.properties.PropertyLoaderStatic;
import Autotest.common.supers.Helper;
import com.codeborne.selenide.SelenideElement;
import org.openqa.selenium.By;
import ru.yandex.qatools.properties.annotations.Property;
import ru.yandex.qatools.properties.annotations.Resource;
import ru.yandex.qatools.properties.annotations.Use;

import java.util.ArrayList;
import java.util.List;

import static com.codeborne.selenide.Condition.*;

@Resource.Classpath("./UWeb/Pages/Page_Profile.properties")
public class Page_Profile extends Helper_my {

    @Property("Default_title")
    private static String TITLE;
    @Property("Bonus_button")
    @Use(ByConverter.class)
    private static By bb_cancelButton;
    @Property("Money_balance")
    @Use(ByConverter.class)
    private static By money_balance;
    @Property("Log_out")
    @Use(ByConverter.class)
    private static By logout_button;
    @Property("Messages_tab")
    @Use(ByConverter.class)
    private static By messages_link;
    @Property("CurrentPP_ref")
    @Use(ByConverter.class)
    private static By current_pp_link;
    @Property("CurrentPP_r")
    @Use(ByConverter.class)
    private static By prepaid_text;
    //Ссылка показать для САС
    @Property("Show_CAC_balance_link")
    @Use(ByConverter.class)
    private static By CAC_balance_link;
    //Сумма САС баланса
    @Property("CAC_balance_sum")
    @Use(ByConverter.class)
    private static By CAC_balance_sum;
    //Валюта САС баланса
    @Property("CAC_balance_currency")
    @Use(ByConverter.class)
    private static By CAC_balance_currency;
    @Property("CAC_balance_add_button")
    @Use(ByConverter.class)
    private static By CAC_balance_add_button;
    @Property("Pay_page")
    @Use(ByConverter.class)
    private static By pay_page;
    @Property("Pay_account")
    @Use(ByConverter.class)
    private static By pay_account;
    @Property("Happy_time_block")
    @Use(ByConverter.class)
    private static By happy_time_block;
    @Property("Transfer_bonuses_block")
    @Use(ByConverter.class)
    private static By transfer_bonuses_block;
    @Property("Transfer_bonus_link")
    @Use(ByConverter.class)
    private static By transfer_bonus_link;
    @Property("No_bonuses_tip")
    @Use(ByConverter.class)
    private static By no_bonuses_tip;
    @Property("Number_input")
    @Use(ByConverter.class)
    private static By number_input;
    @Property("Bonus_sum_input")
    @Use(ByConverter.class)
    private static By bonus_sum_input;
    @Property("Transfer_bonuses_button")
    @Use(ByConverter.class)
    private static By transfer_bonuses_button;
    @Property("CTN_Has_HappyTime_1")
    @Use(ByConverter.class)
    private static By ctn_Has_HappyTime_1;
    @Property("Popup_message")
    @Use(ByConverter.class)
    private static By popup_message;
    @Property("Popup_block")
    @Use(ByConverter.class)
    private static By popup_block;
    @Property("Subscribes_block_link")
    @Use(ByConverter.class)
    private static By subscribes_block_link;
    @Property("No_subscribes_message")
    @Use(ByConverter.class)
    private static By no_subscribes_message;
    /**
     * Проверка, что в болоке есть подписки
     */

    @Property("Subscribes_block")
    @Use(ByConverter.class)
    private static By subscribes;

    /**
     * Блок и ссылка Подключенные услуги
     */

    @Property("Connected_services_link")
    @Use(ByConverter.class)
    private static By link_Connected_services;
    @Property("Connected_services")
    @Use(ByConverter.class)
    private static By Connected_services_block;
    /**
     * Проверка цвета суммы баланса
     *
     * @param colour
     * @return
     */
    // сумма баланса
    @Property("Balance")
    @Use(ByConverter.class)
    private static By balance_sum;
    /**
     * @return
     */

    // сумма баланса
    @Property("Autooplata")
    @Use(ByConverter.class)
    private static By autooplata;

    static {
        PropertyLoaderStatic.populate(Page_Profile.class);
    }

    /**
     * Клик на ссылку Перести бонусы (бонусов нет)
     */
    public void transferBonusesBlock() {
        $(transfer_bonus_link).click();
        $(transfer_bonuses_block).shouldBe(visible);
        fillText(number_input, "9683513600");
        fillText(bonus_sum_input, "1");
        $(transfer_bonuses_button).shouldBe(enabled);
    }

    /**
     * Проверка всплывающего окна и текста в нем
     */

    public void transferBonusesApprove() {
        $(transfer_bonuses_button).click();
        $(popup_block).shouldBe(visible);
        $(popup_message).getText().contains("успешно отправлен");
    }

    /**
     * Клик на ссылку Перевести бонусы (бонусы есть)
     */
    public void noTransferBonusesLink() {
        $(transfer_bonus_link).click();
        $(no_bonuses_tip).shouldBe(visible);
    }

    public String getTitle() {
        return TITLE;
    }

    public String getBalanceMoney() {
        return $(money_balance).getText();
    }

    public SelenideElement getButtonCancelInBonus() {
        return $(bb_cancelButton);
    }

    public void hideBonus() {
        if (getButtonCancelInBonus().isDisplayed()) {
            getButtonCancelInBonus().click();
            Helper.waitABit(3000L);
        }
    }

    /**
     * получение ссылки Текущий тариф
     *
     * @return
     */

    public String getCurrentPPLink() {
        String pp = $(current_pp_link).getText();
        return pp;
    }

    /**
     * получение строки Предоплатная(постоплатная) система расчетов
     *
     * @return
     */
    public String getCurrentPPR() {
        return $(prepaid_text).getText();
    }

    /**
     * Переход в карточку текущего тарифа
     */
    public void gotoCurrentPP() {
        $(current_pp_link).click();
    }

    public void gotoMessages() {
        $(messages_link).click();
    }

    public void logOut() {
        if ($(logout_button).isDisplayed()) {
            $(logout_button).click();
            Helper_my.ClearAllCookies();
            Helper_my.refresh();
        } else System.out.println("Выход не сработал");
    }

    /**
     * Проверка отображения блока допбалансов
     *
     * @return
     */
    public String isAddBalWidgetDisplayed() {
        if (!$("#AddBalanceBlock>table").isDisplayed()) {
            return "Допбалансы на профиле отсутствуют";
        }
        return "Допбалансы на профиле присутствуют";
    }

    /**
     * Проверка наличия допбалансов и их порядок
     */
    public void addBalOrder() {
        SelenideElement addBalances = $("#AddBalanceBlock>table");
        List<String> columns = new ArrayList<String>();
        for (int i = 1; i < 10; i++) {
            columns.add($("//*[@id='AddBalanceBlock']/table/tbody/tr[" + i + "]/td[1]/div").getText());
        }
        columns.forEach(System.out::println);
    }

    /**
     * Проверка наличия блока САС баланса и САС баланса
     */
    public String getCACBalance() {
        $(CAC_balance_link).click();
        waitForElementToBePresent(CAC_balance_sum);
        $(CAC_balance_sum).scrollTo();
        return $(CAC_balance_sum).getText();
    }

    /**
     * Нажать кнопку Пополнить баланс
     */
    public String addCACBalance() {
        $(CAC_balance_add_button).click();
        hideBonus();
        $(pay_page).shouldBe(visible);
        return $(pay_account).getText();
    }

    /**
     * Проверка отображения блока допбалансов
     *
     * @return
     */
    public String isHappyTimeBlockDisplayed() {
        if (!$(happy_time_block).isDisplayed()) {
            return "Блок Счастливого времени на профиле отсутствует";
        }
        return "Блок Счастливого времени на профиле присутствует";
    }

    public boolean isSubscribesBlockDisplayed() {
        return $(subscribes_block_link).isDisplayed();
    }

    /**
     * Клик по ссылке блока с подписками
     */
    public void noSubscriptionsBlock() {
        $(subscribes_block_link).click();
        waitForElementToBePresent(no_subscribes_message);
        //waitForElementToDisappear(loadform);
        $$(no_subscribes_message).get(0).waitUntil(be(enabled), (long) IMPLICITLY_WAIT);
        $(subscribes_block_link).scrollTo();
    }

    /**
     * Проверка что в блоке подписок нет
     */
    public String noSubscriptions() {
        if (!$$(no_subscribes_message).get(0).getText().contains("У вас нет ни одной подписки")) {
            return "Текст не соответствует";
        }
        return "Текст соответствует";
    }

    /**
     * отображение блока с подписками (подписки есть)
     * @return
     */
    public boolean isSubscriptionsDisplayed() {
        $(subscribes_block_link).click();
        $(subscribes_block_link).scrollTo();
        if (!$(subscribes).isDisplayed()) {
            return false;
        }
        return true;
    }

    /**
     * Отключение подписки (клик по крыжику)
     **/
      //активный крыжик
    @Property("Subs_checked_active")
    @Use(ByConverter.class)
    private static By Subs_checked_active;
    public void turnOffSub() {
        $(Subs_checked_active).click();
    }

    /**
     * Отключение подписки в попапе
     */
    //попап отключения подписки
    @Property("Subs_turnoff_popup")
    @Use(ByConverter.class)
    private static By Subs_turnoff_popup;
    //ссылка "Не отключать"
    @Property("Subs_no_turnoff")
    @Use(ByConverter.class)
    private static By Subs_no_turnoff;

    //неактивный крыжик
    @Property("Subs_checked_inactive")
    @Use(ByConverter.class)
    private static By Subs_checked_inactive;

    public void turningOffSub() {
        $(Subs_turnoff_popup).shouldBe(visible);
        $(Subs_no_turnoff).click();
        $(Subs_turnoff_popup).shouldNotBe(visible);
    }

    public boolean isConnectedServicesBlockDisplayed() {
        return $(Connected_services_block).isDisplayed();
    }

    public boolean isConnectedServicesLinkDisplayed() {
        return $(link_Connected_services).isDisplayed();
    }

    public String colorSumFont(String colour) {
        return $(balance_sum).getCssValue("color");
        /*if ($(balance_sum).getCssValue("color") != colour) {
            return true;
        }
        return false;
    }*/
    }

    public String Autooplata(int i) {
        return $$(autooplata).get(i).getText();
    }


}