xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaDeudores" element="ns1:consultaDeudores" location="../../CobranzasElectronicas/xsd/cobranzasElectronicasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:InputParameters" location="../../../BusinessServices/ABK/consultarDeudoresCliente/xsd/consultarDeudoresCliente_sp.xsd" ::)

declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarDeudoresCliente";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/cobranzasElectronicasTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/PagingTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDeudores/xq/consultaDeudoresIn/";

declare function xf:consultaDeudoresIn($consultaDeudores as element(ns1:consultaDeudores))
    as element(ns2:InputParameters) {
        <ns2:InputParameters>
            <ns2:PV_CODCLIENTE>{ data($consultaDeudores/CUSTOMER_ID) }</ns2:PV_CODCLIENTE>
            <ns2:PV_NUMEROCONTRATO>{ data($consultaDeudores/CONTRACT_ID) }</ns2:PV_NUMEROCONTRATO>
            {
                for $DEBTOR_CODE in $consultaDeudores/DEBTOR_CODE
                return
                    <ns2:PV_CODDEUDOR>{ data($DEBTOR_CODE) }</ns2:PV_CODDEUDOR>
            }
            {
                for $DEBTOR_NAME in $consultaDeudores/DEBTOR_NAME
                return
                    <ns2:PV_NOMDEUDOR>{ data($DEBTOR_NAME) }</ns2:PV_NOMDEUDOR>
            }
            <ns2:PN_REGINICIAL>
                { 
                    if (data($consultaDeudores/PAGING_INFO/PAGING/text()) = "YES") then
                        data($consultaDeudores/PAGING_INFO/INITIAL_RECORD)
                    else
                        ("")
                }
            </ns2:PN_REGINICIAL>
            <ns2:PN_CANTREGISTROS>
                { 
                    if (data($consultaDeudores/PAGING_INFO/PAGING/text()) = "YES") then
                        data($consultaDeudores/PAGING_INFO/RECORD_COUNT)
                    else
                        ("")
                }
            </ns2:PN_CANTREGISTROS>
        </ns2:InputParameters>
};

declare variable $consultaDeudores as element(ns1:consultaDeudores) external;

xf:consultaDeudoresIn($consultaDeudores)