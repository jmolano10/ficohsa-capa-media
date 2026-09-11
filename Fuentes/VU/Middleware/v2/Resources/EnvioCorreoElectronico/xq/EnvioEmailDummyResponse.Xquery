<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://TargetNamespace.com/ServiceName";
(:: import schema at "../xsd/envioEmailResponse.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare variable $input as xs:string external;

declare function xq:EnvioEmailDummyResponse($input as xs:string) as element() (:: schema-element(ns1:Root-Element) ::) {
    <ns1:Root-Element>
        <ns1:code>2</ns1:code>
        <ns1:message>2</ns1:message>
        <ns1:emailOperation>
            <ns1:id>2</ns1:id>
            <ns1:subject>2</ns1:subject>
            <ns1:message>2</ns1:message>
            <ns1:toEmailAccounts>2</ns1:toEmailAccounts>
            <ns1:ccEmailAccounts>2</ns1:ccEmailAccounts>
            <ns1:ccoEmailAccounts>2</ns1:ccoEmailAccounts>
            <ns1:attachments>2</ns1:attachments>
            <ns1:status>2</ns1:status>
            <ns1:creationTimestamp>2</ns1:creationTimestamp>
            <ns1:updateTimestamp>2</ns1:updateTimestamp>
        </ns1:emailOperation>
    </ns1:Root-Element>
};

xq:EnvioEmailDummyResponse($input)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../xsd/envioEmailResponse.xsd">
            <con:schema ref="Middleware/v2/Resources/EnvioCorreoElectronico/xsd/envioEmailResponse"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>