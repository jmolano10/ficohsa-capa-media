(:: pragma bea:global-element-parameter parameter="$consultaFacturas1" element="ns0:consultaFacturas" location="../../CobranzasElectronicas/xsd/cobranzasElectronicasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:InputParameters" location="../../../BusinessServices/ABK/consultaFacturasCliente/xsd/consultaFacturasCliente_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/cobranzasElectronicasTypes";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaFacturasCliente";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/PagingTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/consultaFacturasCliente/xq/consultaFacturasClienteIn/";

declare function xf:consultaFacturasClienteIn($consultaFacturas1 as element(ns0:consultaFacturas),
    $ticketOSB as xs:string)
    as element(ns2:InputParameters) {
        <ns2:InputParameters>
            <ns2:PV_CODIGOCLIENTE>{ data($consultaFacturas1/CUSTOMER_ID) }</ns2:PV_CODIGOCLIENTE>
			<ns2:PV_NUMEROCONTRATO>{ data($consultaFacturas1/CONTRACT_ID) }</ns2:PV_NUMEROCONTRATO>
			{
			    for $DEBTOR_CODE in $consultaFacturas1/DEBTOR_CODE
			    return
			        <ns2:PV_CODIGODEUDOR>{ data($DEBTOR_CODE) }</ns2:PV_CODIGODEUDOR>
			}
			<ns2:PD_FECHAINICIO>{ data($consultaFacturas1/BEGIN_DATE) }</ns2:PD_FECHAINICIO>
			<ns2:PD_FECHAFIN>{ data($consultaFacturas1/END_DATE) }</ns2:PD_FECHAFIN>
			{
			    let $paging := $consultaFacturas1/PAGING_INFO/PAGING
			    let $INITIAL_RECORD := $consultaFacturas1/PAGING_INFO/INITIAL_RECORD
			    let $RECORD_COUNT := $consultaFacturas1/PAGING_INFO/RECORD_COUNT
			    return
			        if ($paging = 'YES') then
			            (<ns2:PN_REGISTROINICIAL>{ data($INITIAL_RECORD) }</ns2:PN_REGISTROINICIAL>,
			             <ns2:PN_CANTIDADREGISTROS>{ data($RECORD_COUNT) }</ns2:PN_CANTIDADREGISTROS>,
			             <ns2:PV_TICKETOSB>{ $ticketOSB}</ns2:PV_TICKETOSB>)                        
			        else 
			            ()
			}
			{
			    let $estado := $consultaFacturas1/BILL_STATUS/PGD
			    return
			        if($estado = 'YES') then(
			            <ns2:PN_PAGADA>1</ns2:PN_PAGADA>
			        )else (
			            <ns2:PN_PAGADA>0</ns2:PN_PAGADA>
			        )           
			}
			{
			    let $estado := $consultaFacturas1/BILL_STATUS/PPA
			    return
			        if($estado = 'YES') then(
			            <ns2:PN_PAGOPARCIAL>1</ns2:PN_PAGOPARCIAL>
			        )else (
			            <ns2:PN_PAGOPARCIAL>0</ns2:PN_PAGOPARCIAL>
			        )           
			}
			{
			    let $estado := $consultaFacturas1/BILL_STATUS/PEN
			    return
			        if($estado = 'YES') then(
			            <ns2:PN_PENDIENTE>1</ns2:PN_PENDIENTE>
			        )else (
			            <ns2:PN_PENDIENTE>0</ns2:PN_PENDIENTE>
			        )           
			}
			{
			    let $estado := $consultaFacturas1/BILL_STATUS/ANU
			    return
			        if($estado = 'YES') then(
			            <ns2:PN_ANULADA>1</ns2:PN_ANULADA>
			        )else (
			            <ns2:PN_ANULADA>0</ns2:PN_ANULADA>
			        )           
			}
			{
			    let $estado := $consultaFacturas1/BILL_STATUS/ERR
			    return
			        if($estado = 'YES') then(
			            <ns2:PN_ERROR>1</ns2:PN_ERROR>
			        )else (
			            <ns2:PN_ERROR>0</ns2:PN_ERROR>
			        )           
			}
			{
			    let $estado := $consultaFacturas1/BILL_STATUS/ELM
			    return
			        if($estado = 'YES') then(
			            <ns2:PN_ELIMINADA>1</ns2:PN_ELIMINADA>
			        )else (
			            <ns2:PN_ELIMINADA>0</ns2:PN_ELIMINADA>
			        )           
			}
			{
			    let $estado := $consultaFacturas1/BILL_STATUS/PRE_ALT
			    return
			        if($estado = 'YES') then(
			            <ns2:PN_PRE_ALTA>1</ns2:PN_PRE_ALTA>
			        )else (
			            <ns2:PN_PRE_ALTA>0</ns2:PN_PRE_ALTA>
			        )           
			}
			{
			    let $estado := $consultaFacturas1/BILL_STATUS/PRE_ELM
			    return
			        if($estado = 'YES') then(
			            <ns2:PN_PRE_ELIMINADA>1</ns2:PN_PRE_ELIMINADA>
			        )else (
			            <ns2:PN_PRE_ELIMINADA>0</ns2:PN_PRE_ELIMINADA>
			        )           
			}
			{
			    let $estado := $consultaFacturas1/BILL_STATUS/PRE_ANU
			    return
			        if($estado = 'YES') then(
			            <ns2:PN_PRE_ANULADA>1</ns2:PN_PRE_ANULADA>
			        )else (
			            <ns2:PN_PRE_ANULADA>0</ns2:PN_PRE_ANULADA>
			        )           
			}         
        </ns2:InputParameters>
};

declare variable $consultaFacturas1 as element(ns0:consultaFacturas) external;
declare variable $ticketOSB as xs:string external;

xf:consultaFacturasClienteIn($consultaFacturas1,$ticketOSB)