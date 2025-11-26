(:: pragma bea:global-element-parameter parameter="$pagoRecaudoMigracion" element="ns1:pagoRecaudoMigracion" location="../../xsds/PagoRecaudoMigracion/PagoRecaudoMigracion.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../xsds/Recaudos/ConsultarRelacionOperacionRecaudoMigracion/FLINK_OSB_CON_OPER_RECAUDO_MIGRACION.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoMigracionTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_CON_OPER_RECAUDO_MIGRACION/";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRecaudoMigracion/PagoRecaudoMigracionConsultarRelOperRecaudoMigracionIn/";

declare function xf:PagoRecaudoMigracionConsultarRelOperRecaudoMigracionIn($pagoRecaudoMigracion as element(ns1:pagoRecaudoMigracion))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:NUMERO_IDENTIDAD>{ data($pagoRecaudoMigracion/ORD_PARTY_ID) }</ns0:NUMERO_IDENTIDAD>
        </ns0:InputParameters>
};

declare variable $pagoRecaudoMigracion as element(ns1:pagoRecaudoMigracion) external;

xf:PagoRecaudoMigracionConsultarRelOperRecaudoMigracionIn($pagoRecaudoMigracion)