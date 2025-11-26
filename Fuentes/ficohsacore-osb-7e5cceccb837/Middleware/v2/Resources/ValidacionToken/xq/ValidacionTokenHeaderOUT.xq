(:: pragma bea:schema-type-return type="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidacionToken/xq/ValidacionTokenHeaderOUT/";

declare function xf:ValidacionTokenHeaderOUT($SuccessIndicator as xs:string,
    $ErrorMessage as xs:string)
    as element() {
        <ns0:ResponseHeader>
            <successIndicator>{ $SuccessIndicator }</successIndicator>
          {
           if($SuccessIndicator="ERROR") then (
             <messages>{ $ErrorMessage }</messages>
           )
           else()
          }
        </ns0:ResponseHeader>
};

declare variable $SuccessIndicator as xs:string external;
declare variable $ErrorMessage as xs:string external;

xf:ValidacionTokenHeaderOUT($SuccessIndicator,
    $ErrorMessage)