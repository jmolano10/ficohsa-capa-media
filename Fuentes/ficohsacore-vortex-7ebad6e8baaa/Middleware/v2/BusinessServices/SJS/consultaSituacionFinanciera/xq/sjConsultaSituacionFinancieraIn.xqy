xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjConsultaSituacionFinanciera" element="ns1:sjConsultaSituacionFinanciera" location="../xsd/sjConsultaSituacionFinanciera.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaSituacionFinancieraInterno" location="../../../../Resources/ConsultaSituacionFinanciera/xsd/consultaSituacionFinancieraTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaSituacionFinancieraTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaSituacionFinanciera";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaSituacionFinanciera/xq/sjConsultaSituacionFinancieraIn/";

declare function xf:sjConsultaSituacionFinancieraIn($sjConsultaSituacionFinanciera as element(ns1:sjConsultaSituacionFinanciera),
    $country as xs:string)
    as element(ns0:consultaSituacionFinancieraInterno) {
        <ns0:consultaSituacionFinancieraInterno>
            <UUID>{ data($sjConsultaSituacionFinanciera/UUID) }</UUID>
            {
                for $REGION in $sjConsultaSituacionFinanciera/REGIONS/REGION[ID=$country]
                return
                    <REGION>
                        <ID>{ data($REGION/ID) }</ID>
                        <CUSTOMERS>
                        	{
	                        	for $CUSTOMER in $REGION/CUSTOMERS/CUSTOMER
	                        	return
		                        	<CUSTOMER>
										<ID>{fn:string($CUSTOMER/ID/text())}</ID>
										<REGION>{fn:string($CUSTOMER/REGION/text())}</REGION>
										<PRODUCT_TYPE>{fn:string($CUSTOMER/PRODUCT_TYPE/text())}</PRODUCT_TYPE>
									</CUSTOMER>
							}		
				    	</CUSTOMERS>
                        <PRODUCTS>
                        	{
	                        	for $PRODUCT in $REGION/PRODUCTS/PRODUCT
		                        return
									<PRODUCT>
										<TYPE>{fn:string($PRODUCT/TYPE/text())}</TYPE>
										<ID>{fn:string($PRODUCT/ID/text())}</ID>
										<REGION>{fn:string($PRODUCT/REGION/text())}</REGION>											
							    	</PRODUCT>
					    	}
						</PRODUCTS>
                    </REGION>
            }
        </ns0:consultaSituacionFinancieraInterno>
};

declare variable $sjConsultaSituacionFinanciera as element(ns1:sjConsultaSituacionFinanciera) external;
declare variable $country as xs:string external;

xf:sjConsultaSituacionFinancieraIn($sjConsultaSituacionFinanciera,
    $country)