<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$compruebaElegibilidad" element="ns0:compruebaElegibilidad" location="../../DigitalizacionTarjetas/xsd/digitalizacionTarjetasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:encripterDataRequest" location="../../../BusinessServices/encripterData/wsdl/encripterData.wsdl" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/schema/encripterDataTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/digitalizacionTarjetasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CompruebaElegibilidad/xq/encripterDataIn/";

declare function xf:encripterDataIn($compruebaElegibilidad as element(ns0:compruebaElegibilidad))
    as element(ns1:encripterDataRequest) {
        &lt;ns1:encripterDataRequest>
            &lt;request>{ concat("Desencriptar","|#",data($compruebaElegibilidad/ENCRYPTED_CARD_INFO/ENCRYPTED_DATA),"|#",data($compruebaElegibilidad/ENCRYPTED_CARD_INFO/NONCE),"|#","A9A7D19EBCC8ACA31B41AA174C0BCFC0","|#",data($compruebaElegibilidad/ENCRYPTED_CARD_INFO/MAC_LENGTH)) }&lt;/request>
        &lt;/ns1:encripterDataRequest>
};

declare variable $compruebaElegibilidad as element(ns0:compruebaElegibilidad) external;

xf:encripterDataIn($compruebaElegibilidad)</con:xquery>
    <con:dependency location="../../DigitalizacionTarjetas/xsd/digitalizacionTarjetasTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/DigitalizacionTarjetas/xsd/digitalizacionTarjetasTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/encripterData/wsdl/encripterData.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/encripterData/wsdl/encripterData"/>
    </con:dependency>
</con:xqueryEntry>