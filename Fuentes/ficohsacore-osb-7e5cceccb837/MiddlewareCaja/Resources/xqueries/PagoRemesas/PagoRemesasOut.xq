(:: pragma bea:global-element-parameter parameter="$pagoderemesasResponse" element="ns0:PagoderemesasResponse" location="../../xsds/Remesas/XMLSchema_-1855765488.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaderemesaResponse" element="ns0:ConsultaderemesaResponse" location="../../xsds/Remesas/XMLSchema_-1855765488.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadeusuariosdelsistemaResponse" element="ns0:ConsultadeusuariosdelsistemaResponse" location="../../xsds/Core/XMLSchema_1632682327.xsd" ::)
(:: pragma bea:global-element-return element="ns1:pagoRemesasResponse" location="../../xsds/PagoRemesas/PagoRemesas.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRemesasTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRemesas/PagoRemesasOut/";

declare function xf:PagoRemesasOut($pagoderemesasResponse as element(ns0:PagoderemesasResponse),
    $consultaderemesaResponse as element(ns0:ConsultaderemesaResponse),
    $consultadeusuariosdelsistemaResponse as element(ns0:ConsultadeusuariosdelsistemaResponse))
    as element(ns1:pagoRemesasResponse) {
        <ns1:pagoRemesasResponse>
            {
                let $result :=
                    for $INPUTTER in $pagoderemesasResponse/TELLERType/gINPUTTER/INPUTTER
                    return
                        <INPUTTER>{ fn:tokenize(data($INPUTTER), "_")[2] }</INPUTTER>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $DATETIME in $pagoderemesasResponse/TELLERType/gDATETIME/DATETIME
                    return
                        <DATE_TIME>{ concat("20",$DATETIME) }</DATE_TIME>
                return
                    $result[1]
            }
            {
                for $LRINVOICEDT in $pagoderemesasResponse/TELLERType/gLRINVOICENO/mLRINVOICENO[1]/LRINVOICEDT
                return
                    <REMITTANCE_DATE>{ data($LRINVOICEDT) }</REMITTANCE_DATE>
            }           
            {
                for $BRANCHNAME in $consultadeusuariosdelsistemaResponse/WSUSERType[1]/gWSUSERDetailType/mWSUSERDetailType[1]/BRANCHNAME
                return
                    <BRANCH_NAME>{ data($BRANCHNAME) }</BRANCH_NAME>
            }
            {
                for $SERVICENAME in $consultaderemesaResponse/WSLATAMAGREMITTANCEINFOType[1]/gWSLATAMAGREMITTANCEINFODetailType/mWSLATAMAGREMITTANCEINFODetailType[1]/SERVICENAME
                return
                    <REMIT_COMPANY_NAME>{ data($SERVICENAME) }</REMIT_COMPANY_NAME>
            }            
            {
                for $LRREMITTID in $pagoderemesasResponse/TELLERType/LRREMITTID
                return
                    <REMITTANCE_ID>{ data($LRREMITTID) }</REMITTANCE_ID>
            }
            {
                for $LRBALDUE in $pagoderemesasResponse/TELLERType/LRBALDUE
                return
                    <REMITTANCE_AMOUNT>{ data($LRBALDUE) }</REMITTANCE_AMOUNT>
            }
            {
                for $CURRENCY2 in $pagoderemesasResponse/TELLERType/CURRENCY2
                return
                    <REMITTANCE_CURRENCY>{ data($CURRENCY2) }</REMITTANCE_CURRENCY>
            }
            {
                for $LRBENNAME in $pagoderemesasResponse/TELLERType/LRBENNAME
                return
                    <BENEFICIARY_NAME>{ data($LRBENNAME) }</BENEFICIARY_NAME>
            }
            {
                for $LRIDENCODE in $pagoderemesasResponse/TELLERType/LRIDENCODE
                return
                    <BENEFICIARY_ID>{ data($LRIDENCODE) }</BENEFICIARY_ID>
            }
            {
                for $LRORDNAME in $pagoderemesasResponse/TELLERType/LRORDNAME
                return
                    <ORD_PARTY_NAME>{ data($LRORDNAME) }</ORD_PARTY_NAME>
            }
            {
                for $LRPARTIALAMT in $pagoderemesasResponse/TELLERType/gLRINVOICENO/mLRINVOICENO[1]/LRPARTIALAMT
                return
                    <EXCHANGE_RATE>{ data($LRPARTIALAMT) }</EXCHANGE_RATE>
            }
            {
                for $LRREMITADD in $pagoderemesasResponse/TELLERType/gLRREMITADD/LRREMITADD
                let $LRMAPID := fn:string($pagoderemesasResponse/TELLERType/LRMAPID/text())
                return
                	<BEN_ADDRESS>{ concat($LRREMITADD , $LRMAPID) }</BEN_ADDRESS>
            }            
            {
                for $LRCOUNTRY in $pagoderemesasResponse/TELLERType/LRCOUNTRY
                return
                    <BEN_COUNTRY>{ data($LRCOUNTRY) }</BEN_COUNTRY>
            }
            {
                for $LRCITY in $pagoderemesasResponse/TELLERType/LRCITY
                return
                    <BEN_CITY>{ data($LRCITY) }</BEN_CITY>
            }
            {
                for $LRREMITMOBILE in $pagoderemesasResponse/TELLERType/LRREMITMOBILE
                return
                    <BEN_PHONE_NUMBER>{ data($LRREMITMOBILE) }</BEN_PHONE_NUMBER>
            }	
            {
            	if (fn:string($pagoderemesasResponse/Status/successIndicator/text()) = "Success") then (
            		let $override :=
	            		for $OVERRIDE in $pagoderemesasResponse/TELLERType/gOVERRIDE/OVERRIDE/text()
	                	return
	                		fn-bea:trim(fn:tokenize($OVERRIDE, ":")[3])
	                return
	                	if(fn:string-join($override, "") != "") then (
	                			<REMITTANCE_PRICE>{ fn:string-join($override, " Y ") }</REMITTANCE_PRICE>
                		) else (
                			<REMITTANCE_PRICE>{ concat(""," ","") }</REMITTANCE_PRICE>
                		)
            	) else(
            		""
            	)
            }
			{
				let $recibo := 
					for $LRBLBATCH at $i in $pagoderemesasResponse/TELLERType/gLRBLBATCH/mLRBLBATCH/LRBLBATCH
					return
						if($LRBLBATCH = "dealslip") then (
							<DEALSLIP>{ data($pagoderemesasResponse/TELLERType/gLRBLREGNO/mLRBLREGNO[$i]/LRBLREGNO) }</DEALSLIP>
						) else () 
				return
					if(fn:string($recibo[1]) = "") then (
						<DEALSLIP>{ concat(""," ","") }</DEALSLIP>
					) else (
						$recibo[1]
					)
        	}
        	
        </ns1:pagoRemesasResponse>
};

declare variable $pagoderemesasResponse as element(ns0:PagoderemesasResponse) external;
declare variable $consultaderemesaResponse as element(ns0:ConsultaderemesaResponse) external;
declare variable $consultadeusuariosdelsistemaResponse as element(ns0:ConsultadeusuariosdelsistemaResponse) external;

xf:PagoRemesasOut($pagoderemesasResponse,
    $consultaderemesaResponse,
    $consultadeusuariosdelsistemaResponse)