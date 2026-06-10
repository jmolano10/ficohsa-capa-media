<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaSituacionFinanciera" element="ns0:consultaSituacionFinanciera" location="../xsd/consultaSituacionFinancieraTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:sjConsultaSituacionFinanciera" location="../../../BusinessServices/SJS/consultaSituacionFinanciera/xsd/sjConsultaSituacionFinanciera.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaSituacionFinancieraTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaSituacionFinanciera";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSituacionFinanciera/xq/consultaSituacionFinancieraIn/";

declare function xf:consultaSituacionFinancieraIn($uuid as xs:string,
    $consultaSituacionFinanciera as element(ns0:consultaSituacionFinanciera))
    as element(ns1:sjConsultaSituacionFinanciera) {
        <ns1:sjConsultaSituacionFinanciera>
            <UUID>{ $uuid }</UUID>
            <REGIONS>
                {                
                let $paises := distinct-values($consultaSituacionFinanciera/PRODUCTS/PRODUCT/REGION union $consultaSituacionFinanciera/CUSTOMERS/CUSTOMER/REGION )
                return
            	for $pais in $paises
            	return(
                    <REGION>
                        <ID>{$pais}</ID>
                        <CUSTOMERS>
                        {
									for $customer in  $consultaSituacionFinanciera/CUSTOMERS/CUSTOMER
									where $customer/REGION = $pais
									return
										<CUSTOMER>
											<ID>{fn:string($customer/ID/text())}</ID>
											<REGION>{fn:string($customer/REGION/text())}</REGION>
											<PRODUCT_TYPE>{fn:string($customer/PRODUCT_TYPE/text())}</PRODUCT_TYPE>
								    	</CUSTOMER>
                    	}
                    	</CUSTOMERS>                        
                        <PRODUCTS>
                        {
									for $producto in  $consultaSituacionFinanciera/PRODUCTS/PRODUCT
									where $producto/REGION = $pais
									return
										<PRODUCT>
											<TYPE>{fn:string($producto/TYPE/text())}</TYPE>
											<ID>{fn:string($producto/ID/text())}</ID>
											<REGION>{fn:string($producto/REGION/text())}</REGION>											
								    	</PRODUCT>
                    	}
                    	</PRODUCTS>                        
                    </REGION>
                    )
                }
            </REGIONS>
        </ns1:sjConsultaSituacionFinanciera>
};

declare variable $uuid as xs:string external;
declare variable $consultaSituacionFinanciera as element(ns0:consultaSituacionFinanciera) external;

xf:consultaSituacionFinancieraIn($uuid,$consultaSituacionFinanciera)]]></con:xquery>
    <con:dependency location="../xsd/consultaSituacionFinancieraTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaSituacionFinanciera/xsd/consultaSituacionFinancieraTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/SJS/consultaSituacionFinanciera/xsd/sjConsultaSituacionFinanciera.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/SJS/consultaSituacionFinanciera/xsd/sjConsultaSituacionFinanciera"/>
    </con:dependency>
</con:xqueryEntry>