package Autotests.UWeb.Utils;

import Autotest.common.utils.NTFileProcessor;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import javax.xml.soap.*;
import java.net.Authenticator;
import java.net.PasswordAuthentication;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import org.apache.commons.codec.binary.Base64;
import org.w3c.dom.Document;
import org.xml.sax.SAXException;

/**
 *
 * @author V.Rakshin
 */
public class SoapClient {

    /**
     * Создать SOAP-запрос, и получить ответ от сервиса
     * 
     * @param url полный путь к сервису, например http://host:port/ecare/?services=ODS_GET_DETAILS_FILE
     * @param login 
     * @param pass
     * @param method имя метода, например ODS_GET_DETAILS_FILE
     * @param parameters строка параметров в виде [параметр=значение, параметр=значение]
     * @return
     * @throws SOAPException
     * @throws Exception 
     */
    public static SOAPMessage getResponse(String url, String login, String pass, String method, String parameters) throws SOAPException, Exception {
        simpleAuth(login, pass);
        // Create SOAP Connection
        SOAPConnection connection = SOAPConnectionFactory.newInstance().createConnection();        
        // Send SOAP Message to SOAP Server
        SOAPMessage soapResponse = connection.call(createSOAPRequest(login, pass, method, parameters), url);
        connection.close();        
        return soapResponse;
    }
    
    /**
     * Создать SOAP-запрос, и получить ответ от сервиса
     * 
     * @param url полный путь к сервису, например http://host:port/ecare/?services=ODS_GET_DETAILS_FILE
     * @param login 
     * @param pass
     * @param path путь к файлу с запросом
     * @return
     * @throws SOAPException
     * @throws Exception 
     */    
    public static SOAPMessage getResponse(String url, String login, String pass, String path) throws SOAPException, Exception {
        // Create SOAP Connection
        SOAPConnection connection = SOAPConnectionFactory.newInstance().createConnection();
        // Send SOAP Message to SOAP Server
        SOAPMessage soapResponse = connection.call(createSOAPRequest(login, pass, path), url);
        connection.close();
        return soapResponse;
    }    

    /**
     * Создать SOAP-запрос
     * 
     * @param login 
     * @param pass
     * @param method имя метода, например ODS_GET_DETAILS_FILE
     * @param parameters строка параметров в виде [параметр=значение, параметр=значение, параметр=значение]
     * @return
     * @throws Exception 
     */
    private static SOAPMessage createSOAPRequest(final String login, final String pass, String method, String parameters) throws Exception {
        //simpleAuth(login, pass); // не работает 

        MessageFactory messageFactory = MessageFactory.newInstance();
        SOAPMessage soapMessage = messageFactory.createMessage();
        
        String loginPassword = login + ":" + pass;
        String encodedString = Base64.encodeBase64String(loginPassword.getBytes());        
        soapMessage.getMimeHeaders().addHeader("Authorization", "Basic " + encodedString);
        
        SOAPPart soapPart = soapMessage.getSOAPPart();

        // SOAP Envelope
        SOAPEnvelope envelope = soapPart.getEnvelope();
        envelope.setPrefix("soapenv");
        envelope.addNamespaceDeclaration("urn", "urn:sap-com:document:sap:rfc:functions");
        envelope.removeNamespaceDeclaration("SOAP-ENV");

        // такая аутентификация не работает на проекте ССВО, но возможно заработате где-то в другом
        /*SOAPHeader head = envelope.getHeader();
        head.setPrefix("soapenv");
        SOAPElement head_al = head.addHeaderElement(new QName("h", "h:BasicAuth"));
        head_al.addChildElement("Name").addTextNode(login);
        head_al.addChildElement("Password").addTextNode(pass);*/
        
        // SOAP Body        
        SOAPBody soapBody = envelope.getBody();
        soapBody.setPrefix("soapenv");
        SOAPElement soapBodyElem = soapBody.addChildElement(method, "urn");
        
        for (String parameter:parameters.split(", ")){
            if (!parameter.contains("=_")){
                soapBodyElem.addChildElement(parameter.split("=")[0]).addTextNode(parameter.split("=")[1]);
            }else{
                soapBodyElem.addChildElement(parameter.split("=")[0]);
            }
        }
        
        soapMessage.saveChanges();

        System.out.println("\nRequest SOAP Message:");
        soapMessage.writeTo(System.out);
        System.out.println("\n");

        return soapMessage;
    }    
    
    /**
     * Создать SOAP-запрос
     * 
     * @param login
     * @param pass
     * @param path путь к файлу с запросом
     * @return
     * @throws Exception 
     */
    private static SOAPMessage createSOAPRequest(final String login, final String pass, String path) throws Exception {
        simpleAuth(login, pass);

        Document doc = getConfFromFile(path);
        
        MessageFactory messageFactory = MessageFactory.newInstance();
        SOAPMessage soapMessage = messageFactory.createMessage();
        SOAPPart soapPart = soapMessage.getSOAPPart();

        // SOAP Envelope
        SOAPEnvelope envelope = soapPart.getEnvelope();
        String name = doc.getDocumentElement().getAttribute("xmlns:urn");
        envelope.addNamespaceDeclaration(name.split(":")[0], name);

        // SOAP Body        
        SOAPBody soapBody = envelope.getBody();
        try{
            name =  doc.getElementsByTagName("SOAP-ENV:Body").item(0).getFirstChild().getNodeName();
        }catch(NullPointerException e){
            name =  doc.getElementsByTagName("soapenv:Body").item(0).getFirstChild().getNodeName();
        }
        
        SOAPElement soapBodyElem = soapBody.addChildElement(name.split(":")[1], name.split(":")[0]);
        
        int num = 0;
        try{
            num = doc.getElementsByTagName("SOAP-ENV:Body").item(0).getFirstChild().getChildNodes().getLength();
        }catch(NullPointerException e){
            num = doc.getElementsByTagName("soapenv:Body").item(0).getFirstChild().getChildNodes().getLength();
        }
        
        for (int i = 0; i < num; i++) {
            org.w3c.dom.Node child;
            
            try{
                child = doc.getElementsByTagName("SOAP-ENV:Body").item(0).getFirstChild().getChildNodes().item(i);
            }catch(NullPointerException e){
                child = doc.getElementsByTagName("soapenv:Body").item(0).getFirstChild().getChildNodes().item(i);
            }
            soapBodyElem.addChildElement(child.getNodeName()).addTextNode(child.getTextContent());
        }
        
        soapMessage.saveChanges();

        System.out.print("\nRequest SOAP Message:\n");
        soapMessage.writeTo(System.out);
        System.out.println();

        return soapMessage;
    }        

    /**
     * Простая аунтификация на сервисе
     * 
     * @param login
     * @param pass 
     */
    private static void simpleAuth(final String login, final String pass) {
        Authenticator myAuth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(login, pass.toCharArray());
            }
        };
        Authenticator.setDefault(myAuth);
    }

    /**
     * Преобразует файл с запросом в объект для удобной работы
     * 
     * @param path путь к файлу
     * @return
     * @throws IOException
     * @throws ParserConfigurationException
     * @throws SAXException 
     */
    private static Document getConfFromFile(String path) throws IOException, ParserConfigurationException, SAXException {
        DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
        dbf.setValidating(false);
        dbf.setIgnoringComments(false);
        dbf.setIgnoringElementContentWhitespace(true);
        dbf.setNamespaceAware(true);
        DocumentBuilder db = null;
        db = dbf.newDocumentBuilder();
        Document doc = db.parse(path);
        return doc;
    }
 
    /**
     * Получить ответ из сообщения от сервиса
     * 
     * @param msg
     * @return
     * @throws SOAPException
     * @throws IOException 
     */
    public static String getTextFromSOAPMessage(SOAPMessage msg) throws SOAPException, IOException {
        String answ = msg.getSOAPBody().getTextContent();
        System.out.println("Получил ответ: " + answ);
        return answ;
    }       
    
    /**
     * Получить ответ из сообщения от сервиса
     * 
     * @param msg
     * @return
     * @throws SOAPException
     * @throws IOException 
     */
    public static String getEANSWERFromSOAPMessage(SOAPMessage msg) throws SOAPException, IOException {
        String answ = msg.getSOAPBody().getElementsByTagName("E_ANSWER").item(0).getTextContent();
        //System.out.println("Получил ответ: \n" + answ);
        return answ;
    }    
    
    /**
     * Получить ответ из сообщения от сервиса
     * 
     * @param msg
     * @return
     * @throws SOAPException
     * @throws IOException 
     */
    public static String getEDATAFromSOAPMessage(SOAPMessage msg) throws SOAPException, IOException {
        //System.out.println("Получил ответ: \n" + msg.getSOAPBody().toString());
        String answ = msg.getSOAPBody().getElementsByTagName("E_DATA").item(0).getTextContent();
        //System.out.println("Получил ответ: \n" + answ);
        return answ;
    }    
    
    /**
     * Декодировать ответ сервиса 
     * 
     * @param mess
     * @return 
     * @throws java.io.UnsupportedEncodingException 
     */
    public static String decodeMessage(String mess) throws UnsupportedEncodingException{
        Base64 coder = new Base64();
        return new String(coder.decode(mess.getBytes()));
    }
    
    /**
     * Декодировать ответ от сервиса с помощью утилиты base64.exe 
     * (должна лежать в Dependencies\base64\)
     * 
     * @param answer
     * @return путь к декодированному файлу
     * @throws IOException
     * @throws InterruptedException 
     */
    public static String decodeAnswer(String answer) throws IOException, InterruptedException {
        String path_ = NTFileProcessor.getDefaultDownloadPath();
        
        File myFile = new File(path_ + "temp_e");
        if (myFile.isFile()) myFile.delete();
        
        NTFileProcessor.createFile(path_ + "temp_b", answer);
        String command = NTFileProcessor.getDefaultWorkingPath() 
                + "\\Dependencies\\base64\\base64.exe -d \"" + path_ 
                + "temp_b\" \"" + path_ +  "temp_e\"";
        
        Process runner_process = Runtime.getRuntime().exec(command);
        runner_process.waitFor();
        
        System.out.println("decodeAnswer - OK");
        
        return path_ + "temp_e";
    }                
}