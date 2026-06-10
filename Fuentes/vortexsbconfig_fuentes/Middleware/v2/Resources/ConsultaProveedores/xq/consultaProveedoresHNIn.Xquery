<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultarProveedores" element="ns0:consultarProveedores" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/PMSV/consultarProveedores/xsd/consultarProveedores_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarProveedoresPagosMasivos";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaProveedoresPagosMasivos/xq/consultaProveedoresPagosMasivosHNIn/";

declare function xf:consultaProveedoresPagosMasivosHNIn($consultarProveedores as element(ns0:consultarProveedores))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_CODIGOCLIENTE>{ data($consultarProveedores/CUSTOMER_ID) }</ns1:PV_CODIGOCLIENTE>
            <ns1:PV_SITUACION>{ data($consultarProveedores/SUPPLIER_STATUS) }</ns1:PV_SITUACION>
            <ns1:PT_CODIGOSPROVEEDORIN>
            {                
                for $SUPPLIER in $consultarProveedores/SUPPLIERS/SUPPLIER
                return                 
                        <ns1:ITEM>{ data($SUPPLIER/ID) }</ns1:ITEM>                        
            }
            </ns1:PT_CODIGOSPROVEEDORIN>
        </ns1:InputParameters>
};

declare variable $consultarProveedores as element(ns0:consultarProveedores) external;

xf:consultaProveedoresPagosMasivosHNIn($consultarProveedores)]]></con:xquery>
    <con:dependency location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/PagosMasivos/xsd/pagosMasivosTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/PMSV/consultarProveedores/xsd/consultarProveedores_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/PMSV/consultarProveedores/xsd/consultarProveedores_sp"/>
    </con:dependency>
</con:xqueryEntry>