package Autotests.UWeb.pages;

import Autotest.common.supers.Helper;
import Autotest.common.utils.NTFileProcessor;
import com.codeborne.selenide.Selenide;
import com.codeborne.selenide.SelenideElement;
import com.codeborne.selenide.WebDriverRunner;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import org.apache.http.client.fluent.Request;
import org.apache.poi.EncryptedDocumentException;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchWindowException;
import org.testng.Assert;

import java.io.*;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

import static Autotest.common.utils.Utilities.saveUserAgent;
import static com.codeborne.selenide.WebDriverRunner.getWebDriver;

/**
 * @author VRakshin
 */
public class Helper_my extends Helper {



    /**
     * Получить текст выбранного элемента из списка выбора
     *
     * @param path
     * @return
     */
    public String getTextFromSelect(By path) {
        return $(path).getSelectedText();
    }

    /**
     * Выбрать из выпадающего списка необходимый элемент по value
     *
     * @param path
     * @param val
     */
    public void selectFromListByValue(By path, String val) {
        $(path).selectOptionByValue(val);
    }

    /**
     * Выбрать из выпадающего списка необходимый элемент
     *
     * @param path
     * @param text
     * @throws InterruptedException
     */
    public void selectFromListByText(By path, String text) throws InterruptedException {
        $(path).selectOption(text);
    }

    public SelenideElement getSelectElement(By path) {
        return $(path);
    }

    public boolean isButtonEnabled(String buttonValue) {
        return getButtonElement(buttonValue).isEnabled();
    }

    public boolean isSelectEnabled(By select) {
        return getSelectElement(select).isEnabled();
    }

    public boolean isButtonExist(String buttonValue) {
        return !($$b(By.xpath("//input[@value='" + buttonValue + "']")).isEmpty());
    }

    public SelenideElement getButtonElement(String buttonValue) {
        return $(By.xpath("//input[@value='" + buttonValue + "']"));
    }

    public void setCheckboxRadio(By path, boolean booleanValue) {
        $(path).setSelected(booleanValue);
        waitUntilAjaxFinished();
    }

    public boolean getCheckboxRadio(By path) {
        return $(path).isSelected();
    }

    public void clickOnButton(String buttonValue) {
        getButtonElement(buttonValue).click();
        waitUntilAjaxFinished();
    }

    /**
     * Добавляет строчку текста к файлу
     *
     * @param text   строка
     * @param name   полное имя файла с путём
     * @param delete удалить файл, если он есть, перед записью в него
     */
    public static void addDataToFile(String text, String name, boolean delete) {
        File flt = new File(name);

        if (flt.exists()) {
            if (delete) {
                try {
                    flt.delete();
                } catch (Exception e) {
                    System.out.println("\tCouldn't delete file \n" + e.getMessage() + "\n");
                }
            }
        }

        try {
            PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(flt, true)));
            out.print(text);
            out.flush();
        } catch (IOException e) {
            System.out.println("\tCouldn't create file \n" + e.getMessage() + "\n");
        }
    }

    /**
     * Переводит файл в строку
     *
     * @param file
     * @return
     * @throws java.lang.Exception
     */
    public static String getStringFromFile(File file) throws Exception {
        Scanner scanner = null;
        try {
            scanner = new Scanner(file);
        } catch (Exception e) {
            throw new Exception(e);
        }

        String line = "";
        boolean first = true;
        while (scanner.hasNextLine()) {
            if (first) {
                line = scanner.nextLine();
                first = false;
            } else {
                line = line + "\n" + scanner.nextLine();
            }
        }

        scanner.close();
        return line;
    }

    /**
     * Берёт нужную строку из файла
     *
     * @param file_path
     * @param str       продстрока, которую ищем в строке
     * @return
     * @throws java.lang.Exception
     */
    public static String getStringFromFile(String file_path, String str) throws Exception {
        Scanner scanner = null;
        try {
            scanner = new Scanner(new File(file_path));
        } catch (Exception e) {
            throw new Exception(e);
        }
        String line = "";
        while (scanner.hasNextLine()) {
            line = scanner.nextLine();
            if (line.contains(str)) break;
        }
        scanner.close();
        return line;
    }

    public static String getStringFromFile(String path) throws Exception {
        return getStringFromFile(new File(path));
    }

    public List<String> convertListElemToListString(By path) {
        return convertListElemToListString(path, true);
    }

    public List<String> convertListElemToListString(By path, boolean save_empty) {
        List<String> returns = new ArrayList<>();
        for (SelenideElement el : $$b(path)) {
            Helper.setTimeoutMinimum();
            try {
                String txt = el.getText();
                if (txt.equals("")) {
                    if (save_empty) returns.add(txt);
                } else {
                    returns.add(txt);
                }
            } catch (Exception ex) {
            }
        }
        Helper.setTimeoutBack();

        return returns;
    }

    public void openWindow(String URL) {
        String win = "";
        try {
            win = getDriver().getWindowHandle();
        } catch (NoSuchWindowException e) {
            System.out.println("Нет открытых окон");
            WebDriverRunner.closeWebDriver();
            System.out.println("Закрыл браузер");
        }

        if (win.isEmpty()) {
            System.out.print("Открываю " + URL + "\n");
            saveUserAgent(getWebDriver());
            WebDriverRunner.clearBrowserCache();
            getDriver().get(URL);
        }
    }

    public File getSaveFile(By Button) {
        NTFileProcessor.clearDownloadsFolder();
        Selenide.executeJavaScript("arguments[0].click()", $(Button));
        return (NTFileProcessor.getSavedFile());
    }

    public void checkThatFileContainString(File file, String text) throws IOException {
        checkThatFileContainString(file, text, "\n");
    }

    public void checkThatFileXlsContainString(File file_xls, int row, int column, String text) throws IOException {
        checkThatFileXlsContainString(file_xls, row - 1, column - 1, text, "\n");
    }

    public void checkThatFileContainString(File xml, String text, String splitter) throws IOException {
        String fnum = new String(Files.readAllBytes(xml.toPath()));
        for (String line : text.split(splitter)) {
            Assert.assertTrue(fnum.contains(line.trim()),
                    "Строка '" + line + "' в файле не найдена");
        }
    }

    public void checkThatFileXlsContainString(File file_xls, int row, int column, String text, String splitter) throws IOException {
        String cell = getValueCell(file_xls.getAbsolutePath(), row, column);
        if (text.isEmpty()) {
            Assert.assertTrue(cell.isEmpty(), "Ячейка не пустая : " + cell);
        } else if (text.contains(splitter)) {
            for (String line : text.split(splitter)) {
                Assert.assertTrue(cell.contains(line),
                        "Строка '" + line + "' в ячейке не найдена");
            }
        } else {
            Assert.assertTrue(cell.contains(text),
                    "Строка '" + text + "' в ячейке не найдена");
        }
    }

    public void checkThatStringContainString(String string, String text, String splitter) throws IOException {
        for (String line : text.split(splitter)) {
            Assert.assertTrue(string.contains(line.trim()),
                    "Строка '" + line + "' в строке не найдена");
        }
    }

    public void checkThatServicesPresent(By path, String services) {
        for (String srv : services.split(", ")) {
            if (srv.contains(":")) {
                Boolean find = false;
                for (SelenideElement tt : $(path).$$("tr")) {
                    if (tt.$("td:nth-child(2)").text().equals(srv.split(":")[0])) {
                        Assert.assertTrue(tt.$("td:nth-child(4)").text().equals(srv.split(":")[1]),
                                "Статус сервиса " + srv.split(":")[0] + " некорректен.");
                        find = true;
                        break;
                    }
                }
                Assert.assertTrue(find, "Сервис " + srv.split(":")[0] + " не найден");
            } else {
                Boolean find = false;
                for (SelenideElement tt : $(path).$$("tr")) {
                    if (tt.$("td:nth-child(2)").text().equals(srv)) {
                        find = true;
                        break;
                    }
                }
                Assert.assertTrue(find, "Сервис " + srv + " не найден");
            }
        }
    }

    public void checkThatPeriodicServicePresent(By path, String services) {
        for (String srv : services.split(", ")) {
            Boolean find = false;
            for (SelenideElement tt : $(path).$$("tr")) {
                if (tt.$("td:nth-child(2)").text().equals(srv.split(":")[0])) {
                    String date = srv.split(":")[1];
                    Assert.assertTrue(tt.$("td:nth-child(5)").text().equals(date),
                            "Дата списания сервиса " + srv.split(":")[0] + " некорректна");
                    checkStatusPeriodicService(date, tt, srv);
                    find = true;
                    break;
                }
            }
            Assert.assertTrue(find, "Сервис " + srv.split(":")[0] + " не найден");
        }
    }

    private void checkStatusPeriodicService(String date, SelenideElement tt, String srv) {
        if (date.equals("01.01.2029")) {
            Assert.assertTrue(tt.$("td:nth-child(4)").text()
                            .contains("Фин.блок"),
                    "Статус сервиса " + srv.split(":")[0] + " некорректен");
        } else if (date.equals("31.12.2029")) {
            Assert.assertTrue(tt.$("td:nth-child(4)").text()
                            .contains("Блок по желанию"),
                    "Статус сервиса " + srv.split(":")[0] + " некорректен");
        }
    }

    /**
     * Открыть файл с SQL, заменить в нём дату и номер, если они есть на нужные
     * и послать эти запросы в БД
     *
     * @param path
     * @param depth
     * @param number
     * @throws Exception
     */
    public void changeAndSendQuery(String path, int depth, String number) throws Exception {
        String que = "";
        if (path.length() > 5) {
            boolean err = false;
            try {
                Helper_my.getStringFromFile(new File(path));
            } catch (Exception e) {
                err = true;
            }

            if (!err) {
                if (depth == 0) {
                    que = Helper_my.getStringFromFile(new File(path))
                            .replace("subscr_num:='9038888888';", "subscr_num:='" + number.split(":")[0] + "';")
                            .replace("bill_system:='28';", "bill_system:='" + number.split(":")[1] + "';");
                } else {
                    que = Helper_my.getStringFromFile(new File(path))
                            .replace("trn_date:=sysdate - 8;", "trn_date:=sysdate - " + (depth - 1) + ";")
                            .replace("subscr_num:='9038888888';", "subscr_num:='" + number.split(":")[0] + "';")
                            .replace("bill_system:='28';", "bill_system:='" + number.split(":")[1] + "';");
                }
                //TODO при релизе раскомментить
                //new BDHelper().sendQueryCud("odscmv", que);
            }
        } else {
            //path = System.getProperty("user.dir") + "/target/classes/SQL/inserts_for_filters.sql";
            //bd.sendQueryCud("odscmv", que);
        }
    }

    /**
     * Создать файл с необходимым текстом
     *
     * @param text
     * @return
     * @throws IOException
     */
    public File getStringLikeFile(String text) throws IOException {
        return NTFileProcessor.createFile("temp", text);
    }

    /**
     * Создать файл с необходимым текстом
     *
     * @param name если есть такой файл, то он затирается
     * @param text
     * @return
     * @throws IOException
     */
    public File getStringLikeFile(String name, String text) throws IOException {
        return NTFileProcessor.createFile(name, text);
    }

    public String getValueCell(String path, int row_, int column_) throws FileNotFoundException, IOException {
        InputStream inp;

        try {
            inp = new FileInputStream(path);
        } catch (FileNotFoundException ex) {
            throw new FileNotFoundException("Файл '" + path + "' не найден.");
        }

        Workbook wb = null;
        try {
            wb = WorkbookFactory.create(inp);
        } catch (InvalidFormatException | EncryptedDocumentException ex) {
            ex.printStackTrace();
        }
        Sheet sheet = wb.getSheetAt(0);
        String tr_id = "";
        try {
            tr_id = sheet.getRow(row_).getCell(column_).getStringCellValue();
        } catch (Throwable e) {
            try {
                tr_id = sheet.getRow(row_).getCell(column_).getNumericCellValue() + "";
            } catch (Throwable ee) {
                tr_id = "";
            }
        }

        inp.close();
        return tr_id;
    }

    /**
     * Омистка кук при выходе из ЛК
     */
    public static void ClearAllCookies()
    {
        WebDriverRunner.getWebDriver().manage().deleteAllCookies();
    }
}