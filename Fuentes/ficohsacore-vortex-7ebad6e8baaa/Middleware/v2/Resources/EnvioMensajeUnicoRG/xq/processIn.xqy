xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$envioMensajeUnico" element="ns1:envioMensajeUnico" location="../../EnvioCorreoElectronico/xsd/envioCorreoElectronicoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:uniquemailRequest" location="../../../BusinessServices/OIC/uniqueEmail/xsd/XMLSchema_1636307889.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/uniquemail/uniquemail/BPELuniquemail";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/envioCorreoElectronicoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EnvioCorreoElectronico/xq/processIn/";

declare function xf:processIn($envioMensajeUnico as element(ns1:envioMensajeUnico))
    as element(ns0:uniquemailRequest) {
        <ns0:uniquemailRequest>
            <ns0:GeneralData>
                <ns0:FromName>{ data($envioMensajeUnico/FROM/NAME) }</ns0:FromName>
                <ns0:From>{ data($envioMensajeUnico/FROM/ADDRESS) }</ns0:From>
                <ns0:To>
                    {
                        for $ADDRESS in $envioMensajeUnico/DESTINATION/ADDRESS
                        return
                            <ns0:email>{ $ADDRESS/@* , $ADDRESS/node() }</ns0:email>
                    }
                </ns0:To>
                <ns0:Cc>
                    {
                        for $ADDRESS in $envioMensajeUnico/DESTINATION_CC/ADDRESS
                        return
                            <ns0:email>{ $ADDRESS/@* , $ADDRESS/node() }</ns0:email>
                    }
                </ns0:Cc>
                <ns0:Bcc>
                    {
                        for $ADDRESS in $envioMensajeUnico/DESTINATION_BCC/ADDRESS
                        return
                            <ns0:email>{ $ADDRESS/@* , $ADDRESS/node() }</ns0:email>
                    }
                </ns0:Bcc>
                <ns0:Message>
                    <ns0:Subject>{ data($envioMensajeUnico/MESSAGE/SUBJECT) }</ns0:Subject>
                    <ns0:Classification>{ data($envioMensajeUnico/MESSAGE/CLASSIFICATION) }</ns0:Classification>
                    <ns0:BaseOn>
                        <ns0:Id>{ data($envioMensajeUnico/MESSAGE/BASED_ON/ID) }</ns0:Id>
                        <ns0:Type>{ data($envioMensajeUnico/MESSAGE/BASED_ON/TYPE) }</ns0:Type>
                    </ns0:BaseOn>
                    <ns0:Body>
                        <ns0:Format>{ data($envioMensajeUnico/MESSAGE/BODY/FORMAT) }</ns0:Format>
                        <ns0:Value>{ data($envioMensajeUnico/MESSAGE/BODY/VALUE) }</ns0:Value>
                        {
                            for $VARIABLE in $envioMensajeUnico/MESSAGE/BODY/VARIABLES/VARIABLE
                            return
                                <ns0:Variables>
                                    <ns0:Name>{ data($VARIABLE/NAME) }</ns0:Name>
                                    <ns0:Value>{ data($VARIABLE/VALUE) }</ns0:Value>
                                </ns0:Variables>
                        }
                    </ns0:Body>
                    {
                        for $ATTACHMENT in $envioMensajeUnico/MESSAGE/ATTACHMENTS/ATTACHMENT
                        return
                            <ns0:Attachment>
                                <ns0:FileName>{ data($ATTACHMENT/FILENAME) }</ns0:FileName>
                                <ns0:Encode>{ data($ATTACHMENT/ENCODE) }</ns0:Encode>
                                <ns0:Size>{ data($ATTACHMENT/SIZE) }</ns0:Size>
                                <ns0:Value>{ data($ATTACHMENT/VALUE) }</ns0:Value>
                            </ns0:Attachment>
                    }
                </ns0:Message>
                <ns0:Options>
                    <ns0:OpenTracking>{ data($envioMensajeUnico/OPTIONS/OPTION[fn:upper-case(NAME) = 'OPEN_TRACKING']/VALUE) }</ns0:OpenTracking>
                    <ns0:ClickTracking>{ data($envioMensajeUnico/OPTIONS/OPTION[fn:upper-case(NAME) = 'CLICK_TRACKING']/VALUE) }</ns0:ClickTracking>
                    <ns0:TextHtmlTracking>{ data($envioMensajeUnico/OPTIONS/OPTION[fn:upper-case(NAME) = 'TEXT_HTML_TRACKING']/VALUE) }</ns0:TextHtmlTracking>
                    <ns0:AutoTextBody>{ data($envioMensajeUnico/OPTIONS/OPTION[fn:upper-case(NAME) = 'AUTO_TEXT_BODY']/VALUE) }</ns0:AutoTextBody>
                    <ns0:Personalization>{ data($envioMensajeUnico/OPTIONS/OPTION[fn:upper-case(NAME) = 'PERSONALIZATION']/VALUE) }</ns0:Personalization>
                </ns0:Options>
            </ns0:GeneralData>
        </ns0:uniquemailRequest>
};

declare variable $envioMensajeUnico as element(ns1:envioMensajeUnico) external;

xf:processIn($envioMensajeUnico)