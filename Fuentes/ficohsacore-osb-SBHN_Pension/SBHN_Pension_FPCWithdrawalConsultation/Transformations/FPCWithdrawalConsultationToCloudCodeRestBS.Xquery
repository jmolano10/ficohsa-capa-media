<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/regional/pension";
(:: import schema at "../Schemas/APIFPCTypes.xsd", 
                     "../Schemas/FPCWithdrawalConsultationTypes.xsd" ::)

declare variable $FPCWithdrawalConsultation as element() (:: schema-element(ns1:FPCWithdrawalConsultation) ::) external;

declare function local:funcFPCWithdrawalConsultationToCloudCodeRestBS($FPCWithdrawalConsultation as element() (:: schema-element(ns1:FPCWithdrawalConsultation) ::)) as element() (:: schema-element(ns1:CloudCode) ::) {
    <ns1:CloudCode>
        <numeroSolicitud>{fn:data($FPCWithdrawalConsultation/RequestNumber)}</numeroSolicitud>
        <numeroIdentificacion>{fn:data($FPCWithdrawalConsultation/ClientId)}</numeroIdentificacion>
    </ns1:CloudCode>
};

local:funcFPCWithdrawalConsultationToCloudCodeRestBS($FPCWithdrawalConsultation)]]></con:xquery>
</con:xqueryEntry>