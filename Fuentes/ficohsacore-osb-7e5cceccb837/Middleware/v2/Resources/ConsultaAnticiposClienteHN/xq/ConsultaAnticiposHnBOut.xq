(:: pragma bea:global-element-parameter parameter="$consultaanticiposdisponiblesctaResponse1" element="ns0:ConsultaanticiposdisponiblesctaResponse" location="../../../BusinessServices/T24/AnticiposCliente/xsd/XMLSchema_-361259320.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaAnticiposClienteResponse" location="../../ConsultaAnticiposCliente/xsd/consultaAnticiposClienteTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaAnticiposClienteTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaAnticiposCliente/xq/ConsultaAnticiposBOut/";

declare function xf:ConsultaAnticiposBOut($codCliente as xs:string,
    $consultaanticiposdisponiblesctaResponse1 as element(ns0:ConsultaanticiposdisponiblesctaResponse))
    as element(ns1:consultaAnticiposClienteResponse) {
	if (fn:string($consultaanticiposdisponiblesctaResponse1/FICOECARELIEFWSType[1]/ZERONORECORDS/text()) = "") then
	(    
        <ns1:consultaAnticiposClienteResponse>
            <CREDIT_LINES>
                <CUSTOMER_ID>{ $codCliente }</CUSTOMER_ID>                                         
                
                  {
                  let $detailsType := $consultaanticiposdisponiblesctaResponse1/FICOECARELIEFWSType[1]/gFICOECARELIEFWSDetailType/mFICOECARELIEFWSDetailType
                  for $i in (1 to count($detailsType))
					return
					<CREDIT_LINE>	
							<ACCOUNT_NUMBER>{ data($detailsType[$i]/ID) }</ACCOUNT_NUMBER>									
                            <STATUS>{ data($detailsType[$i]/CASTATUS) }</STATUS>
                            <USED_AMOUNT>{ data($detailsType[$i]/CAUSEDAMT) }</USED_AMOUNT>
                            <FEE_AMOUNT>{ data($detailsType[$i]/CACOMMAMT) }</FEE_AMOUNT>
                            <TOTAL_AMOUNT>{data($detailsType[$i]/CATOTAMT) }</TOTAL_AMOUNT>
                    </CREDIT_LINE> 
                  }
               
            </CREDIT_LINES>
        </ns1:consultaAnticiposClienteResponse>
	)else (
	<ns1:consultaAnticiposClienteResponse/>
	)        
};

declare variable $codCliente as xs:string external;
declare variable $consultaanticiposdisponiblesctaResponse1 as element(ns0:ConsultaanticiposdisponiblesctaResponse) external;

xf:ConsultaAnticiposBOut($codCliente,
    $consultaanticiposdisponiblesctaResponse1)