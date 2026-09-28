(:: pragma bea:global-element-parameter parameter="$sjConsultaActivosPasivosClienteResponseIN" element="ns0:sjConsultaActivosPasivosClienteResponse" location="../../../BusinessServices/SJS/consultaActivosPasivosCliente/xsd/sjConsultaActivosPasivosCliente.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$sjConsultaListasClienteResponseIN" element="ns2:sjConsultaListasClienteResponse" location="../../ConsultaListasCliente/xsd/sjConsultaListasCliente.xsd" ::)
(:: pragma bea:global-element-return element="ns1:validaDatosClienteResponse" location="../../AperturaProductos/xsd/aperturaProductosTypes.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaListasCliente";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/aperturaProductosTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaActivosPasivosCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaDatosCliente/xq/validaDatosClienteOut/";

declare function mensajeRespuesta($successIndicator as xs:string) as xs:string {
	if (upper-case($successIndicator) = 'SUCCESS') then (
		'YES'
    ) else if (upper-case($successIndicator) = 'NO RECORDS' ) then (
    	'NO'
    ) else (
       'ERROR'
    )
};


declare function mensajeRespuestaPasivos($successIndicator as xs:string, $registros as xs:decimal) as xs:string {
	if (($successIndicator = 'Success')and $registros > 0) then (
		'YES'
    ) else if (($successIndicator = 'Success') and $registros = 0) then (
    	'NO'
    ) else (
    	'ERROR'
    )
};


(: Función que determina si cliente está o no en una lista :)
declare function CustomerStatus($customerName as xs:string, $successIndicator as xs:string) as xs:string {
	if (fn:upper-case($successIndicator) = "SUCCESS") then (
		if ($customerName != "") then (
			"YES"
		) else (
			"NO"
		)
	) else if (fn:upper-case($successIndicator) = "NOMATCH") then (
		"NO"
	) else if (fn:upper-case($successIndicator) = "HINT") then (
		"I"
	) else if (fn:upper-case($successIndicator) = "RELUCTANT") then (
		"R"
	) else (
		"ERROR"
	)
};



declare function xf:validaDatosClienteOut($sjConsultaActivosPasivosClienteResponseIN as element(ns0:sjConsultaActivosPasivosClienteResponse),
    $sjConsultaListasClienteResponseIN as element(ns2:sjConsultaListasClienteResponse),
    $CostumerID as xs:string,
    $CustomerName as xs:string,
    $LegalID as xs:string,
    $existsCustomer as xs:string,
    $Customer_Error_Message as xs:string,
    $UserID as xs:string,
    $existsUsername as xs:string,
    $User_Error_Message as xs:string,
    $isLiability as xs:string,
    $isAssets as xs:string,
    $isCostumer as xs:string,
    $isUser as xs:string,
    $isList as xs:string )
    as element(ns1:validaDatosClienteResponse) {
        <ns1:validaDatosClienteResponse>
            <LEGAL_ID>{ $LegalID }</LEGAL_ID>
             {
             if ($CustomerName !='') then(
            <CUSTOMER_NAME>{ $CustomerName }</CUSTOMER_NAME>
              )else()
	          }  
            {
             if ($isList ='YES') then(
            <ASSOCIATIONS_LIST>
	            {
	            	for $ASSOCIATION in $sjConsultaListasClienteResponseIN/ns2:consultaListaClienteResponse
	            	return
	                <ASSOCIATION>
	                    <NAME>{ data($ASSOCIATION/ns2:ASSOCIATION_NAME) }</NAME>
	                    <STATUS>{ CustomerStatus(fn:string($ASSOCIATION/ns2:CUSTOMER_NAME/text()),fn:string($ASSOCIATION/ns2:successIndicator/text())) }</STATUS>
	                </ASSOCIATION>
	            }
	            </ASSOCIATIONS_LIST>
	            )else()
	          }  
	          
	          {
             if ($isCostumer ='YES') then(
            <CUSTOMER_INFORMATION>
                <CUSTOMER_ID>{ $CostumerID }</CUSTOMER_ID>
                <STATUS>{ $existsCustomer }</STATUS>
                 {
                 if (fn:string($existsCustomer) = ("ERROR")) then(
                 <ERROR_MESSAGE>{ $Customer_Error_Message }</ERROR_MESSAGE>
                 )else()
                 }
            </CUSTOMER_INFORMATION>
            )else()
               }
              {
             if ( $isUser ='YES') then(
            <USER_INFORMATION>
                <USER_ID>{ $UserID }</USER_ID>
                <STATUS>{ $existsUsername }</STATUS>
                 {
                 if (fn:string($existsUsername) = ("ERROR")) then(
                 <ERROR_MESSAGE>{ $User_Error_Message }</ERROR_MESSAGE>
                  )else()
	             }
                 </USER_INFORMATION>
             )else()
	             }
	        {
             if ($isAssets ='YES') then(
            <ASSETS_INFORMATION>
                 {
	            	for $ASSETSAHO in $sjConsultaActivosPasivosClienteResponseIN/ns0:ASSETS_INFORMATION/ns0:ASSET
	            	return
	                
	               
	            	if(fn:count($ASSETSAHO/ns0:consultaActivosClienteAhorrosResponseType/ns0:SUCCESS_INDICATOR)>=1) then(
	            	
	            	 <ASSET>
	            	      <TYPE>AHO</TYPE>
                           <STATUS>{ mensajeRespuesta($ASSETSAHO/ns0:consultaActivosClienteAhorrosResponseType/ns0:SUCCESS_INDICATOR/text()) }</STATUS>
	            	 </ASSET>
	            	)
	               else()
	                }
	                {
	                for $ASSETSCHQ in $sjConsultaActivosPasivosClienteResponseIN/ns0:ASSETS_INFORMATION/ns0:ASSET
	            	return
	               
	               if(fn:count($ASSETSCHQ/ns0:consultaActivosClienteCorrienteResponseType/ns0:SUCCESS_INDICATOR)>=1) then(
	            	 <ASSET>
	            	      <TYPE>CHQ</TYPE>
                           <STATUS>{ mensajeRespuesta($ASSETSCHQ/ns0:consultaActivosClienteCorrienteResponseType/ns0:SUCCESS_INDICATOR/text()) }</STATUS>
	            	 </ASSET>
	            	)
	               else()
	               }
	                {
	                for $ASSETSDEP in $sjConsultaActivosPasivosClienteResponseIN/ns0:ASSETS_INFORMATION/ns0:ASSET
	            	return
	               
	               if(fn:count($ASSETSDEP/ns0:consultaActivosClienteDepositosResponseType/ns0:SUCCESS_INDICATOR)>=1) then(
	            	 <ASSET>
	            	      <TYPE>DEP</TYPE>
                           <STATUS>{ mensajeRespuesta($ASSETSDEP/ns0:consultaActivosClienteDepositosResponseType/ns0:SUCCESS_INDICATOR/text()) }</STATUS>
	            	 </ASSET>
	            	)
	               else()
	               }
	                {
	                for $ASSETSFPC in $sjConsultaActivosPasivosClienteResponseIN/ns0:ASSETS_INFORMATION/ns0:ASSET
	            	return
	               
	               if(fn:count($ASSETSFPC/ns0:consultaActivosClientePensionesResponseType/ns0:SUCCESS_INDICATOR)>=1) then(
	            	 <ASSET>
	            	      <TYPE>FPC</TYPE>
                           <STATUS>{ mensajeRespuesta($ASSETSFPC/ns0:consultaActivosClientePensionesResponseType/ns0:SUCCESS_INDICATOR/text()) }</STATUS>
	            	 </ASSET>
	            	)
	               else()
	               }
	               {
	               for $ASSETSSTATUS in $sjConsultaActivosPasivosClienteResponseIN//ns0:ASSETS_STATUS/ns0:STATUS
	            	return
	               
	               if($ASSETSSTATUS/ns0:SUCCESS_INDICATOR/text()!='Success') then(
	            	
                    <ERROR_MESSAGE>{$ASSETSSTATUS/ns0:ERROR_MESSAGE/text() }</ERROR_MESSAGE>
	            	
	            	)
	               else()
	               }
            </ASSETS_INFORMATION>
            )else()
	             }
	             {
             if ($isLiability ='YES') then(
             <LIABILITY_INFORMATION>
                 {
	               let $StatusLIABILITY :=$sjConsultaActivosPasivosClienteResponseIN/ns0:LIABILITIES_STATUS/ns0:STATUS/ns0:SUCCESS_INDICATOR/text()
	            	for $LIABILITYPTM in $sjConsultaActivosPasivosClienteResponseIN/ns0:LIABILITIES_INFORMATION/ns0:LIABILITIY
	            	return
	                
	               
	            	if(fn:count($LIABILITYPTM/ns0:consultaPasivosClientePrestamosResponseType)>=1) then(
	            	
	            	 <LIABILITY>
	            	      <TYPE>PTM</TYPE>
                           <STATUS>{ mensajeRespuestaPasivos($StatusLIABILITY,fn:count($LIABILITYPTM/ns0:consultaPasivosClientePrestamosResponseType/ns0:consultaPasivosClienteResponseRecordType/LIABILITY_TYPE))}</STATUS>
	            	 </LIABILITY>
	            	)
	               else()
	                }
	                {
	                let $StatusLIABILITY :=$sjConsultaActivosPasivosClienteResponseIN/ns0:LIABILITIES_STATUS/ns0:STATUS/ns0:SUCCESS_INDICATOR/text()
	                for $LIABILITYTRC in $sjConsultaActivosPasivosClienteResponseIN/ns0:LIABILITIES_INFORMATION/ns0:LIABILITIY
	            	return
	                
	               
	            	if(fn:count($LIABILITYTRC/ns0:consultaPasivosClienteTCreditoResponseType)>=1) then(
	            	
	            	 <LIABILITY>
	            	      <TYPE>TRC</TYPE>
                           <STATUS>{ mensajeRespuestaPasivos($StatusLIABILITY,fn:count($LIABILITYTRC/ns0:consultaPasivosClienteTCreditoResponseType/ns0:consultaPasivosClienteResponseRecordType/LIABILITY_TYPE))}</STATUS>
	            	 </LIABILITY>
	            	)
	               else()
	                }
	               
	               {
	               let $StatusLIABILITY :=$sjConsultaActivosPasivosClienteResponseIN/ns0:LIABILITIES_STATUS/ns0:STATUS/ns0:SUCCESS_INDICATOR/text()
	               for $LIABILITYSTATUS in $sjConsultaActivosPasivosClienteResponseIN/ns0:LIABILITIES_STATUS/ns0:STATUS
	            	return
	               
	               if($StatusLIABILITY!='Success') then(
	            	
                    <ERROR_MESSAGE>{$LIABILITYSTATUS/ns0:ERROR_MESSAGE/text() }</ERROR_MESSAGE>
	            	
	            	)
	               else()
	               }
            </LIABILITY_INFORMATION>
            )else()
	             }
        </ns1:validaDatosClienteResponse>
};

declare variable $sjConsultaActivosPasivosClienteResponseIN as element(ns0:sjConsultaActivosPasivosClienteResponse) external;
declare variable $sjConsultaListasClienteResponseIN as element(ns2:sjConsultaListasClienteResponse) external;
declare variable $CostumerID as xs:string external;
declare variable $CustomerName as xs:string external;
declare variable $LegalID as xs:string external;
declare variable $existsCustomer as xs:string external;
declare variable $Customer_Error_Message as xs:string external;
declare variable $UserID as xs:string external;
declare variable $existsUsername as xs:string external;
declare variable $User_Error_Message as xs:string external;
declare variable $isLiability as xs:string external;
declare variable $isAssets as xs:string external;
declare variable $isCostumer as xs:string external;
declare variable $isUser as xs:string external;
declare variable $isList as xs:string external;

xf:validaDatosClienteOut($sjConsultaActivosPasivosClienteResponseIN,
    $sjConsultaListasClienteResponseIN,
    $CostumerID,
    $CustomerName,
    $LegalID,
    $existsCustomer,
    $Customer_Error_Message,
    $UserID,
    $existsUsername,
    $User_Error_Message,
    $isLiability,
    $isAssets,
    $isCostumer,
    $isUser,
    $isList)