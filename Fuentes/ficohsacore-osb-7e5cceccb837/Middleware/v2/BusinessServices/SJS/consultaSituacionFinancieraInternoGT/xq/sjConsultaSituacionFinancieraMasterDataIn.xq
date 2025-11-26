(:: pragma bea:schema-type-parameter parameter="$group" type="ns0:GROUP" location="../../../../Resources/ConsultaSituacionFinanciera/xsd/sjConsultaSituacionFinancieraInterno.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../MasterData/conConsultaSituacionFinanciera/xsd/conConsultaSituacionFinanciera_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaSituacionFinancieraInterno";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conConsultaSituacionFinanciera";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaSituacionFinancieraInternoGT/xq/sjConsultaSituacionFinancieraMasterDataIn/";

declare function xf:sjConsultaSituacionFinancieraMasterDataIn($group as element())
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
                <ns1:Pais>GTM</ns1:Pais>
            <ns1:XML_CLIENTES>
            
               <CUSTOMERS>
                  {
                     for $customer in $group/CUSTOMERS/CUSTOMER
	    	          return
                       <CUSTOMER>
            
                        <ID>{data($customer/ID)}</ID>
        
                        <REGION>{data($customer/REGION)}</REGION>
         
                        <PRODUCT_TYPE>{data($customer/PRODUCT_TYPE)}</PRODUCT_TYPE>
                        
                      </CUSTOMER>   
                 }            
               </CUSTOMERS>
            
            </ns1:XML_CLIENTES>
        </ns1:InputParameters>
};

declare variable $group as element() external;

xf:sjConsultaSituacionFinancieraMasterDataIn($group)