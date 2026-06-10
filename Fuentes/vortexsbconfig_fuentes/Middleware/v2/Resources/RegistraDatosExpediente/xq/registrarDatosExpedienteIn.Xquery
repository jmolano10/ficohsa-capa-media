<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$registraDatosExpediente" element="ns1:registraDatosExpediente" location="../../DigitalizacionExpediente/xsd/digitalizacionExpedienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKGT/registrarDatosExpediente/xsd/registrarDatosExpediente_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarDatosExpediente";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/digitalizacionExpedienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistraDatosExpediente/xq/registrarDatosExpedienteIn/";

declare function xf:registrarDatosExpedienteIn($registraDatosExpediente as element(ns1:registraDatosExpediente))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PT_CAMPOS>
               {
                  for $key in $registraDatosExpediente/FIELDS/FIELD
                  return
                <ns0:PT_CAMPOS_ITEM>{ data($key/NAME) }</ns0:PT_CAMPOS_ITEM>
               }
            </ns0:PT_CAMPOS>
            <ns0:PT_VALORES>
               {
                  for $value in $registraDatosExpediente/FIELDS/FIELD
                  return
                <ns0:PT_CAMPOS_ITEM>{ data($value/VALUE) }</ns0:PT_CAMPOS_ITEM>
               }
            </ns0:PT_VALORES>
        </ns0:InputParameters>
};

declare variable $registraDatosExpediente as element(ns1:registraDatosExpediente) external;

xf:registrarDatosExpedienteIn($registraDatosExpediente)]]></con:xquery>
    <con:dependency location="../../DigitalizacionExpediente/xsd/digitalizacionExpedienteTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/DigitalizacionExpediente/xsd/digitalizacionExpedienteTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ABKGT/registrarDatosExpediente/xsd/registrarDatosExpediente_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKGT/registrarDatosExpediente/xsd/registrarDatosExpediente_sp"/>
    </con:dependency>
</con:xqueryEntry>