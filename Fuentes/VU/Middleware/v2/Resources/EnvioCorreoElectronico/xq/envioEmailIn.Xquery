<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/envioCorreoElectronicoTypes";
(:: import schema at "../xsd/envioCorreoElectronicoTypes.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare variable $toEmailAccounts as xs:string external;
declare variable $ccEmailAccounts as xs:string external;
declare variable $ccoEmailAccounts as xs:string external;
declare variable $message as xs:string external;
declare variable $subject as xs:string external;

declare function xq:envioEmailIn($toEmailAccounts as xs:string, 
                                 $ccEmailAccounts as xs:string, 
                                 $ccoEmailAccounts as xs:string, 
                                 $message as xs:string, 
                                 $subject as xs:string) 
                                 as element() (:: schema-element(ns1:envioMensajeUnico) ::) {
    <ns1:envioMensajeUnico>
        <FROM>
            <NAME>TEST</NAME>
        </FROM>
        <DESTINATION>
            <ADDRESS>{fn:data($toEmailAccounts)}</ADDRESS>
        </DESTINATION>
        <DESTINATION_CC>
            <ADDRESS>{fn:data($ccEmailAccounts)}</ADDRESS>
        </DESTINATION_CC>
        <DESTINATION_BCC>
            <ADDRESS>{fn:data($ccoEmailAccounts)}</ADDRESS>
        </DESTINATION_BCC>
        <MESSAGE>
            <SUBJECT>{fn:data($subject)}</SUBJECT>
            <BODY>
                <VARIABLES>
                    <VARIABLE>
                        <NAME>TOTP</NAME>
                        <VALUE>{fn:data($message)}</VALUE>
                    </VARIABLE>
                </VARIABLES>
            </BODY>
        </MESSAGE>
    </ns1:envioMensajeUnico>
};

xq:envioEmailIn($toEmailAccounts, $ccEmailAccounts, $ccoEmailAccounts, $message, $subject)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../xsd/envioCorreoElectronicoTypes.xsd">
            <con:schema ref="Middleware/v2/Resources/EnvioCorreoElectronico/xsd/envioCorreoElectronicoTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>