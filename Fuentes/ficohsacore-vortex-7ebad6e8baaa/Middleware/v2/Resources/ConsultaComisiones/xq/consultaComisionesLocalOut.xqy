xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadecomisionACH_ValidateResponse" element="ns0:ConsultadecomisionACH_ValidateResponse" location="../../../BusinessServices/ACH/consultaComisionACH/xsd/XMLSchema_-1548829260.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaComisionesResponse" location="../xsd/consultaComisionesTypes.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaComisionesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaComisiones/xq/consultaComisionesLocalOut/";

declare function xf:consultaComisionesLocalOut($consultadecomisionACH_ValidateResponse as element(ns0:ConsultadecomisionACH_ValidateResponse))
    as element(ns1:consultaComisionesResponse) {
        <ns1:consultaComisionesResponse>
            {
            	for $consultadecomisionACHValResponse in $consultadecomisionACH_ValidateResponse/FICOHNACHONLINEType
            	return 
            		if($consultadecomisionACHValResponse/COMMISSIONAMOUNT != '' and $consultadecomisionACHValResponse/CREDITCCY != '') then(
                    	<CURRENCY>{ data($consultadecomisionACHValResponse/CREDITCCY) }</CURRENCY>,
            			<AMOUNT>{ data($consultadecomisionACHValResponse/COMMISSIONAMOUNT) }</AMOUNT>
            		)else()
            }
        </ns1:consultaComisionesResponse>
};

declare variable $consultadecomisionACH_ValidateResponse as element(ns0:ConsultadecomisionACH_ValidateResponse) external;

xf:consultaComisionesLocalOut($consultadecomisionACH_ValidateResponse)