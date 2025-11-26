(:: pragma bea:global-element-parameter parameter="$consultaLoteDeudores" element="ns1:consultaLoteDeudores" location="../../CobranzasElectronicas/xsd/cobranzasElectronicasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:InputParameters" location="../../../BusinessServices/ABK/consultarLoteDeudores/xsd/consultarLoteDeudores_sp.xsd" ::)

declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarLoteDeudores";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/cobranzasElectronicasTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/PagingTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaLoteDeudores/xq/consultaLoteDeudoresIn/";

declare function xf:consultaLoteDeudoresIn($consultaLoteDeudores as element(ns1:consultaLoteDeudores))
    as element(ns2:InputParameters) {
        <ns2:InputParameters>
            <ns2:PV_CODIGOCLIENTE>{ data($consultaLoteDeudores/CUSTOMER_ID) }</ns2:PV_CODIGOCLIENTE>
            <ns2:PV_NUMEROCONTRATO>{ data($consultaLoteDeudores/CONTRACT_ID) }</ns2:PV_NUMEROCONTRATO>
            <ns2:PN_IDLOTE>{ data($consultaLoteDeudores/BANK_BATCH_ID) }</ns2:PN_IDLOTE>
            <ns2:PN_REGISTROINICIAL>
                { 
                    if (data($consultaLoteDeudores/PAGING_INFO/PAGING/text()) = "YES") then
                        data($consultaLoteDeudores/PAGING_INFO/INITIAL_RECORD)
                    else
                        ("")
                }
            </ns2:PN_REGISTROINICIAL>
            <ns2:PN_CANTIDADREGISTROS>
                { 
                    if (data($consultaLoteDeudores/PAGING_INFO/PAGING/text()) = "YES") then
                        data($consultaLoteDeudores/PAGING_INFO/RECORD_COUNT)
                    else
                        ("")
                }
            </ns2:PN_CANTIDADREGISTROS>
        </ns2:InputParameters>
};

declare variable $consultaLoteDeudores as element(ns1:consultaLoteDeudores) external;

xf:consultaLoteDeudoresIn($consultaLoteDeudores)