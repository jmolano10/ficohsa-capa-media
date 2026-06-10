<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaPrestamoTypeRequest1" element="ns1:ConsultaPrestamoTypeRequest" location="ConsultaPrestamosCliente.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadeprestamosporcliente" location="../../../consultaGeneralPrestamo/Resources/consultaPrestamoT24/XMLSchema_448646516.xsd" ::)

declare namespace ns1 = "ConsultaPrestamosCliente";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaPasivosCliente/consultaPrestamos/ConsultaPrestamosT24ClienteIn/";

declare function xf:ConsultaPrestamosT24ClienteIn($consultaPrestamoTypeRequest1 as element(ns1:ConsultaPrestamoTypeRequest))
    as element(ns0:Consultadeprestamosporcliente) {
        <ns0:Consultadeprestamosporcliente>
            <WebRequestCommon>
                <userName>{ data($consultaPrestamoTypeRequest1/ns1:AUTHENTICATION_T24/ns1:USERNAME[1]) }</userName>
                <password>{ data($consultaPrestamoTypeRequest1/ns1:AUTHENTICATION_T24/ns1:PASSWORD[1]) }</password>
            </WebRequestCommon>
            <WSFICOLINKAALOANSType>
                <enquiryInputCollection>
                    <columnName>CLIENT.ID</columnName>
                    <criteriaValue>{ data($consultaPrestamoTypeRequest1/ns1:PARAMETERS/ns1:CUSTOMERID[1]) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSFICOLINKAALOANSType>
        </ns0:Consultadeprestamosporcliente>
};

declare variable $consultaPrestamoTypeRequest1 as element(ns1:ConsultaPrestamoTypeRequest) external;

xf:ConsultaPrestamosT24ClienteIn($consultaPrestamoTypeRequest1)]]></con:xquery>
    <con:dependency location="ConsultaPrestamosCliente.xsd">
        <con:schema ref="Middleware/Business_Resources/consultasCliente/consultaPasivosCliente/consultaPrestamos/ConsultaPrestamosCliente"/>
    </con:dependency>
    <con:dependency location="../../../consultaGeneralPrestamo/Resources/consultaPrestamoT24/XMLSchema_448646516.xsd">
        <con:schema ref="Middleware/Business_Resources/consultaGeneralPrestamo/Resources/consultaPrestamoT24/XMLSchema_448646516"/>
    </con:dependency>
</con:xqueryEntry>