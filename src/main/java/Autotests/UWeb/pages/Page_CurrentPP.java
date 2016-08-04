package Autotests.UWeb.pages;

import Autotest.common.converters.ByConverter;
import Autotest.common.properties.PropertyLoaderStatic;
import Autotest.common.supers.Helper;
import com.codeborne.selenide.SelenideElement;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import ru.yandex.qatools.properties.annotations.Property;
import ru.yandex.qatools.properties.annotations.Resource;
import ru.yandex.qatools.properties.annotations.Use;

import java.util.List;

import static com.codeborne.selenide.Selenide.$;
import static com.codeborne.selenide.Selenide.close;

@Resource.Classpath("./UWeb/Pages/Page_CurrentPP.properties")
public class Page_CurrentPP extends Helper_my {

    static {
        PropertyLoaderStatic.populate(Page_CurrentPP.class);
    }

    @Property("Current_ctn")
    @Use(ByConverter.class)
    private static By current_ctn_link;

    @Property("Logout_link")
    @Use(ByConverter.class)
    private static By logout_link;

    @Property("Card_PP")
    @Use(ByConverter.class)
    private static By card_current_pp;

    @Property("PP_turned_on")
    @Use(ByConverter.class)
    private static By PP_turned_on;

    /**
     * Выход со страницы текущего ТП
     */
    public void logOut() {
        if ($(current_ctn_link).isDisplayed())
            $(current_ctn_link).click();
        if ($(logout_link).isDisplayed()) {
            $(logout_link).click();
            Helper_my.ClearAllCookies();
            Helper_my.refresh();
        } else System.out.println("Выход не сработал");
    }

    /**
     * @return Отображение карточеки тарифа и зеленого блока подключения
     */
    public String isCardDisplayed() {
        if (!$(card_current_pp).isDisplayed()) {
            return "Блок текущего тарифа не отображён";
        }
        if (!$(PP_turned_on).isDisplayed()) {
            return "Не отображен блок подключения текущего тарифа";
        }
      //  $(PP_turned_on).scrollTo();
        return "Блоки текущего тарифа отображены";
    }

}