<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:envioMensajeUnicoResponse" location="../xsd/envioCorreoElectronicoTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EnvioCorreoElectronico/xq/EnvioCorreoPrIdOUT/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/envioCorreoElectronicoTypes";

declare function xf:EnvioCorreoPrIdOUT()
as element(ns0:envioMensajeUnicoResponse) {
    &lt;ns0:envioMensajeUnicoResponse/>
};


xf:EnvioCorreoPrIdOUT()</con:xquery>
    <con:dependency location="../xsd/envioCorreoElectronicoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/EnvioCorreoElectronico/xsd/envioCorreoElectronicoTypes"/>
    </con:dependency>
</con:xqueryEntry>