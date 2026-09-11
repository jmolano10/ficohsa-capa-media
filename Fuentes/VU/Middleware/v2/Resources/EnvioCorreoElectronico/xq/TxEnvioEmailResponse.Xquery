<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://TargetNamespace.com/ServiceName";
(:: import schema at "../xsd/envioEmailResponse.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/autType";
(:: import schema at "../../Esquemas_Generales/HeaderElements.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare variable $responseHeader as element() (:: schema-element(ns1:ResponseHeader) ::) external;
declare variable $subject as xs:string external;
declare variable $message as xs:string external;
declare variable $toEmailAccounts as xs:string external;
declare variable $ccEmailAccounts as xs:string external;
declare variable $ccoEmailAccounts as xs:string external;
declare variable $creationTimestamp as xs:string external;

declare function local:formatDate($stringDate as xs:string){
let $formatDate := fn:current-dateTime()

(: Convierte string-fecha a epoch :)
let $unixDate := (xs:dateTime($formatDate) - xs:dateTime("1970-01-01T00:00:00-00:00")) div xs:dayTimeDuration('PT0.001S')
return $unixDate
};

declare function xq:TxEnvioEmailResponse($responseHeader as element() (:: schema-element(ns1:ResponseHeader) ::), 
                                         $subject as xs:string, 
                                         $message as xs:string, 
                                         $toEmailAccounts as xs:string, 
                                         $ccEmailAccounts as xs:string, 
                                         $ccoEmailAccounts as xs:string,
                                         $creationTimestamp as xs:string) 
                                         as element() (:: schema-element(ns2:Root-Element) ::) {
    <ns2:Root-Element>
                <ns2:code>
        {
        if (fn:data($responseHeader/successIndicator)='Success')
        then
        '4001'
        else
        if (fn:data($responseHeader/successIndicator)='ERROR')
        then
        '4005'
        else ()
        }
        </ns2:code>
        <ns2:message>{fn:data($responseHeader/messages)}</ns2:message>
        <ns2:emailOperation>
            <ns2:id></ns2:id>
            <ns2:subject>{fn:data($subject)}</ns2:subject>
            <ns2:message>{fn:data($message)}</ns2:message>
            <ns2:toEmailAccounts>{fn:data($toEmailAccounts)}</ns2:toEmailAccounts>
            <ns2:ccEmailAccounts>{fn:data($ccEmailAccounts)}</ns2:ccEmailAccounts>
            <ns2:ccoEmailAccounts>{fn:data($ccoEmailAccounts)}</ns2:ccoEmailAccounts>
            <ns2:attachments></ns2:attachments>
            <ns2:status></ns2:status>
            <ns2:creationTimestamp>{fn:data($creationTimestamp)}</ns2:creationTimestamp>
            <ns2:updateTimestamp>{ xq:formatDate('')}</ns2:updateTimestamp>
        </ns2:emailOperation>
    </ns2:Root-Element>
};

xq:TxEnvioEmailResponse($responseHeader, $subject, $message, $toEmailAccounts, $ccEmailAccounts, $ccoEmailAccounts,$creationTimestamp)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../xsd/envioEmailResponse.xsd">
            <con:schema ref="Middleware/v2/Resources/EnvioCorreoElectronico/xsd/envioEmailResponse"/>
        </con:importSchema>
        <con:importSchema location="../../Esquemas_Generales/HeaderElements.xsd">
            <con:schema ref="Middleware/v2/Resources/Esquemas_Generales/HeaderElements"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>