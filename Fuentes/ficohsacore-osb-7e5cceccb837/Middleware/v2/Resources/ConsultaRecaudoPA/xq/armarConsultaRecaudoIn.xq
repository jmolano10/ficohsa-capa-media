(:: pragma bea:global-element-parameter parameter="$consultaRecaudo" element="ns2:consultaRecaudo" location="../../ConsultaRecaudo/xsd/consultaRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$loginTeleredResponse1" element="ns0:loginTeleredResponse" location="../../LoginTelered/xsd/loginTeleredTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/TercerosPA/armarConsultaRecaudo/xsd/armarConsultaRecaudo_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/loginTeleredTypes";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/armarConsultaRecaudo";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRecaudoPA/xq/armarConsultaRecaudoIn/";

declare function xf:armarConsultaRecaudoIn($consultaRecaudo as element(ns2:consultaRecaudo),
    $usuario as xs:string,
    $loginTeleredResponse1 as element(ns0:loginTeleredResponse))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_IDCONVENIO>{ data($consultaRecaudo/CONTRACT_ID) }</ns1:PV_IDCONVENIO>
            <ns1:PV_CODIGODEUDOR>{ data($consultaRecaudo/DEBTOR_CODE) }</ns1:PV_CODIGODEUDOR>
            <ns1:PV_MONEDA>{ data($consultaRecaudo/CURRENCY) }</ns1:PV_MONEDA>
            {
                for $BILL_AMOUNT in $consultaRecaudo/BILL_AMOUNT
                return
                    <ns1:PV_MONTO>{ data($BILL_AMOUNT) }</ns1:PV_MONTO>
            }
            {
                for $BILL_DATE in $consultaRecaudo/BILL_DATE
                return
                    <ns1:PV_FECHAFACTURA>{ data($BILL_DATE) }</ns1:PV_FECHAFACTURA>
            }
            {
                for $ADDITIONAL_INFO in $consultaRecaudo/ADDITIONAL_INFO
                return
                    <ns1:PT_INFODATA>
                   {
                    for $data at $i in $ADDITIONAL_INFO/DATA
                    return
                    (
                           <ns1:PT_INFODATA_ITEM>
                                  <ns1:NAME>{concat('DATA_',$i)}</ns1:NAME>
                                  <ns1:VALUE>{data($data)}</ns1:VALUE>
                           </ns1:PT_INFODATA_ITEM>
                    )
                    }
                   </ns1:PT_INFODATA>
            }
            {
                for $SESSION_ID in $loginTeleredResponse1/ns0:SESSION_ID
                return
                    <ns1:PV_SESION>{ data($SESSION_ID) }</ns1:PV_SESION>
            }
            <ns1:PV_USUARIOCANAL>{ $usuario }</ns1:PV_USUARIOCANAL>
        </ns1:InputParameters>
};

declare variable $consultaRecaudo as element(ns2:consultaRecaudo) external;
declare variable $usuario as xs:string external;
declare variable $loginTeleredResponse1 as element(ns0:loginTeleredResponse) external;

xf:armarConsultaRecaudoIn($consultaRecaudo,
    $usuario,
    $loginTeleredResponse1)