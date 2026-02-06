xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaSolicitudesCliente" element="ns1:consultaSolicitudesCliente" location="../../DesembolsoLineaCredito/xsd/desembolsoLineaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/DesembolsoLineaCredito/consultaSolicitudesCliente/xsd/consultaSolicitudesCliente_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/desembolsoLineaCreditoTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaSolicitudesCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSolicitudesCliente/xq/consultaSolicitudesClienteHNIn/";


declare function xf:consultaSolicitudesClienteHNIn($consultaSolicitudesCliente as element(ns1:consultaSolicitudesCliente),
    $TICKET as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:P_CUSTOMER_ID>{ data($consultaSolicitudesCliente/CUSTOMER_ID) }</ns0:P_CUSTOMER_ID>
            <ns0:P_BEGIN_DATE>
                {
                    let $beginDate  := data($consultaSolicitudesCliente/BEGIN_DATE)  
                    return
                        if ($beginDate != '') then
                            adjust-date-to-timezone(xs:date($beginDate),())
                        else 
                            ()
                }
			</ns0:P_BEGIN_DATE>
            <ns0:P_END_DATE>
                {
                    let $endDate  := data($consultaSolicitudesCliente/END_DATE)  
                    return
                        if ($endDate != '') then
                        	adjust-date-to-timezone(xs:date($endDate),())
                           
                        else() 
                            
                }
			</ns0:P_END_DATE>
			{
				for $P_STATUS in $consultaSolicitudesCliente/STATUS
				let $status := data($P_STATUS)
				return
					if( $status != "" )then(
						<ns0:P_STATUS>{ xs:int($status) }</ns0:P_STATUS>
					)else()
			}
            
            <ns0:P_PAGING>{ data($consultaSolicitudesCliente/PAGING_INFO/PAGING) }</ns0:P_PAGING>
            {
            	for $P_INITIAL_RECORD in $consultaSolicitudesCliente/PAGING_INFO/INITIAL_RECORD
            	let $initialRecord := data($P_INITIAL_RECORD)
            	return
            		if( $initialRecord != "" )then(
            			<ns0:P_INITIAL_RECORD>{ xs:int($initialRecord) }</ns0:P_INITIAL_RECORD>
        			)else()
            }
            {
            	for $P_RECORD_COUNT in $consultaSolicitudesCliente/PAGING_INFO/RECORD_COUNT
            	let $recordCount := data($P_RECORD_COUNT)
            	return
            		if( $recordCount != "" )then(
            			<ns0:P_RECORD_COUNT>{ xs:int($recordCount) }</ns0:P_RECORD_COUNT>
        			)else()
            }            
            <ns0:P_TICKET>{ $TICKET }</ns0:P_TICKET>
        </ns0:InputParameters>
};

declare variable $consultaSolicitudesCliente as element(ns1:consultaSolicitudesCliente) external;
declare variable $TICKET as xs:string external;

xf:consultaSolicitudesClienteHNIn($consultaSolicitudesCliente,
    $TICKET)