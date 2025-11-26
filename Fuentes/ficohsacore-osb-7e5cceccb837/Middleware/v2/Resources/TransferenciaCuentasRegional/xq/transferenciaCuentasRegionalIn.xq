(:: pragma bea:global-element-parameter parameter="$consultadedetallesdelacuentaResponse" element="ns0:ConsultadedetallesdelacuentaResponse" location="../../../../Business_Resources/ConsultasCuenta/Resources/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadeclienteResponse" element="ns0:ConsultadeclienteResponse" location="../../../../Business_Resources/consultasCliente/Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$transferenciaCuentasRequest" element="ns2:transferenciaCuentasRequest" location="../../TransferenciaCuentas/xsd/transferenciaCuentasType.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/INTFC/transferenciasRegionales/xsd/transferenciasRegionales_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaDetallesCuentaResponse" element="ns4:consultaDetallesCuentaResponse" location="../../ConsultaDetallesCuenta/xsd/consultaDetallesCuentaTypes.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/transferenciasType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/transferenciasRegionales";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciaCuentasRegional/xq/transferenciaCuentasRegionalIn/";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns4 = "http://www.ficohsa.com.hn/middleware.services/consultasType";

declare function xf:transferenciaCuentasRegionalIn($consultadedetallesdelacuentaResponse as element(ns0:ConsultadedetallesdelacuentaResponse),
    $consultadeclienteResponse as element(ns0:ConsultadeclienteResponse),
    $transferenciaCuentasRequest as element(ns2:transferenciaCuentasRequest),
    $consultaDetallesCuentaResponse as element(ns4:consultaDetallesCuentaResponse),
    $SourceBank as xs:string,
    $DestinationBank as xs:string,
	$UUID as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_PAISREMITENTE>{ $SourceBank }</ns1:PV_PAISREMITENTE>
            <ns1:PV_PAISBENEFICIARIO>{ $DestinationBank }</ns1:PV_PAISBENEFICIARIO>
            <ns1:PV_MENSAJEBENEFICIARIO>
            {
            	let $TRANSFER_DETAILS := $transferenciaCuentasRequest/TRANSFER_DETAILS
            	return
            	if (data($TRANSFER_DETAILS) != '') then (
                	string($TRANSFER_DETAILS/text())
                )
                else ()
            }
            </ns1:PV_MENSAJEBENEFICIARIO>   
            <ns1:PV_REFERENCIA>         
            {
            	let $INTERFACE_REFERENCE_NO := $transferenciaCuentasRequest/INTERFACE_REFERENCE_NO
            	return
            	if (data($INTERFACE_REFERENCE_NO) != '') then (
                	string($INTERFACE_REFERENCE_NO/text())
                )
                else ()
            }
            </ns1:PV_REFERENCIA>            
            <ns1:PN_MONTO>{ data($transferenciaCuentasRequest/TRANSFER_AMOUNT) }</ns1:PN_MONTO>
            {
        		if($SourceBank = "HN01") then (
        		
            		for $CUSTOMER in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/CUSTOMER
            		return
                		<ns1:PV_CLIENTEREMITENTE>{ data($CUSTOMER) }</ns1:PV_CLIENTEREMITENTE>,        		
            		for $CURRENCY in $consultadedetallesdelacuentaResponse/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/CURRENCY
            		return
                		<ns1:PV_MONEDACUENTAREMITENTE>{ data($CURRENCY) }</ns1:PV_MONEDACUENTAREMITENTE>,
	        		for $NAME in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/SHORTNAME
	        		return
	            		<ns1:PV_NOMBREREMITENTE>{ data($NAME) }</ns1:PV_NOMBREREMITENTE>,                		                	
                	for $CUENTAREMITENTE in $consultadedetallesdelacuentaResponse/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/ID
	        		return
	            		<ns1:PV_CUENTAREMITENTE>{ data($CUENTAREMITENTE) }</ns1:PV_CUENTAREMITENTE>        		            	
        		) else(
        			for $CUSTOMER in $consultaDetallesCuentaResponse/ns4:consultaDetallesCuentaResponseType/ns4:consultaDetallesCuentaResponseRecordType[1]/CUSTOMER_ID
        			return
        				<ns1:PV_CLIENTEREMITENTE>{ data($CUSTOMER) }</ns1:PV_CLIENTEREMITENTE>,
        			for $CURRENCY in $consultaDetallesCuentaResponse/ns4:consultaDetallesCuentaResponseType/ns4:consultaDetallesCuentaResponseRecordType[1]/CURRENCY
        			return
                    	<ns1:PV_MONEDACUENTAREMITENTE>{ data($CURRENCY) }</ns1:PV_MONEDACUENTAREMITENTE>,
	        		for $NAME in $consultaDetallesCuentaResponse/ns4:consultaDetallesCuentaResponseType/ns4:consultaDetallesCuentaResponseRecordType[1]/ACCOUNT_NAME
	        		return
	            		<ns1:PV_NOMBREREMITENTE>{ data($NAME) }</ns1:PV_NOMBREREMITENTE>,                		                	                    	
        				<ns1:PV_CUENTAREMITENTE>{ data($transferenciaCuentasRequest/DEBIT_ACCOUNT) }</ns1:PV_CUENTAREMITENTE>       		
        		)
        	}
        	{
	        	if($DestinationBank = "HN01") then(
	        		
	        		for $CUSTOMER in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/CUSTOMER
	        		return
	            		<ns1:PV_CLIENTEBENEFICIARIO>{ data($CUSTOMER) }</ns1:PV_CLIENTEBENEFICIARIO>,	    		
	        		for $CURRENCY in $consultadedetallesdelacuentaResponse/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/CURRENCY
	        		return
	            		<ns1:PV_MONEDACUENTABENEFICIARIO>{ data($CURRENCY) }</ns1:PV_MONEDACUENTABENEFICIARIO>,
	            	let $MAIN_ADDRESS_YES_NO := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/MAINADDRESSYN, "!!")
	            	let $ADDRESSLINE1 := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/ADDRESSLINE1, "!!")
	            	let $ADDRESSLINE2 := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/ADDRESSLINE2, "!!")
	        		for $MAINADDRESSYESNO at $i in $MAIN_ADDRESS_YES_NO
	        		return
	        			if ($MAINADDRESSYESNO = "YES") then (
	            			<ns1:PV_DIRECCIONBENEFICIARIO>{ fn:concat(data($ADDRESSLINE1[$i]), data($ADDRESSLINE2[$i])) }</ns1:PV_DIRECCIONBENEFICIARIO>
	            		) else if ($MAINADDRESSYESNO = "NO") then(
	            			<ns1:PV_DIRECCIONBENEFICIARIO></ns1:PV_DIRECCIONBENEFICIARIO>
	            		) else (), 		
	        		for $NAME in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/SHORTNAME
	        		return
	            		<ns1:PV_NOMBREBENEFICIARIO>{ data($NAME) }</ns1:PV_NOMBREBENEFICIARIO>,	        		
	        		for $CUENTABENEFICIARIO in $consultadedetallesdelacuentaResponse/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/ID
	        		return	        			
	            		<ns1:PV_CUENTABENEFICIARIO>{ data($CUENTABENEFICIARIO) }</ns1:PV_CUENTABENEFICIARIO>
	        	) else (
	        		for $CUSTOMER in $consultaDetallesCuentaResponse/ns4:consultaDetallesCuentaResponseType/ns4:consultaDetallesCuentaResponseRecordType[1]/CUSTOMER_ID
        			return
	        			<ns1:PV_CLIENTEBENEFICIARIO>{ data($CUSTOMER) }</ns1:PV_CLIENTEBENEFICIARIO>,
	        		for $CURRENCY in $consultaDetallesCuentaResponse/ns4:consultaDetallesCuentaResponseType/ns4:consultaDetallesCuentaResponseRecordType[1]/CURRENCY
        			return
						<ns1:PV_MONEDACUENTABENEFICIARIO>{ data($CURRENCY) }</ns1:PV_MONEDACUENTABENEFICIARIO>,
						<ns1:PV_DIRECCIONBENEFICIARIO></ns1:PV_DIRECCIONBENEFICIARIO>,
					for $CUSTOMERNAME in $consultaDetallesCuentaResponse/ns4:consultaDetallesCuentaResponseType/ns4:consultaDetallesCuentaResponseRecordType[1]/ACCOUNT_NAME
        			return
					<ns1:PV_NOMBREBENEFICIARIO>{ data($CUSTOMERNAME) }</ns1:PV_NOMBREBENEFICIARIO>,
	        		<ns1:PV_CUENTABENEFICIARIO>{ data($transferenciaCuentasRequest/CREDIT_ACCOUNT) }</ns1:PV_CUENTABENEFICIARIO>
	        	)
	        }
	        {
                for $CURRENCY in $transferenciaCuentasRequest/CURRENCY
                return
                    <ns1:PV_MONEDA>{ data($CURRENCY) }</ns1:PV_MONEDA>
            }
            {
                for $DEBIT_CREDIT in $transferenciaCuentasRequest/DEBIT_CREDIT
                return
                    <ns1:PV_DEBITOCREDITO>{ data($DEBIT_CREDIT) }</ns1:PV_DEBITOCREDITO>
            }
            {
                for $DESCRIPTION in $transferenciaCuentasRequest/DESCRIPTION
                return
                    <ns1:PV_DESCRIPCION>{ data($DESCRIPTION) }</ns1:PV_DESCRIPCION>
            }
            {
                for $ITEM_LEVEL_1 in $transferenciaCuentasRequest/ITEM_LEVEL_1
                return
                    <ns1:PV_FINANCIAL_SECTOR_CATEGORY>{ data($ITEM_LEVEL_1) }</ns1:PV_FINANCIAL_SECTOR_CATEGORY>
            }
            {
                for $ITEM_LEVEL_2 in $transferenciaCuentasRequest/ITEM_LEVEL_2
                return
                    <ns1:PV_FINANCIAL_SECTOR_SUBCATEG>{ data($ITEM_LEVEL_2) }</ns1:PV_FINANCIAL_SECTOR_SUBCATEG>
            }		
			<ns1:PV_UID>{ $UUID }</ns1:PV_UID>			
        </ns1:InputParameters>
};

declare variable $consultadedetallesdelacuentaResponse as element(ns0:ConsultadedetallesdelacuentaResponse) external;
declare variable $consultadeclienteResponse as element(ns0:ConsultadeclienteResponse) external;
declare variable $transferenciaCuentasRequest as element(ns2:transferenciaCuentasRequest) external;
declare variable $consultaDetallesCuentaResponse as element(ns4:consultaDetallesCuentaResponse) external;
declare variable $SourceBank as xs:string external;
declare variable $DestinationBank as xs:string external;
declare variable $UUID as xs:string external;

xf:transferenciaCuentasRegionalIn($consultadedetallesdelacuentaResponse,
    $consultadeclienteResponse,
    $transferenciaCuentasRequest,
    $consultaDetallesCuentaResponse,
    $SourceBank,
    $DestinationBank,
	$UUID)