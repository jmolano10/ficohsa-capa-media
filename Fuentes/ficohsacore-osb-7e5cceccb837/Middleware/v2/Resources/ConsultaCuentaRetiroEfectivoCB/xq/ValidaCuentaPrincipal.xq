(:: pragma bea:global-element-parameter parameter="$consultaCuentasAfiliadasTarjetaDebitoResponse1" element="ns0:consultaCuentasAfiliadasTarjetaDebitoResponse" location="../../../../Business_Resources/tarjetasDebito/consultaCuentasAfiliadasTarjetaDebito/consultaCuentasAfiliadasTarjetaDebitoTypes.xsd" ::)
(:: jgarcia - 31102017 :)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaCuentasAfiliadasTarjetaDebitoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCuentaRetiroEfectivoCB/xq/ValidaCuentaPrincipal/";

declare function xf:ValidaCuentaPrincipal($consultaCuentasAfiliadasTarjetaDebitoResponse1 as element(ns0:consultaCuentasAfiliadasTarjetaDebitoResponse))
    as xs:string {
        
        let $cuenta := $consultaCuentasAfiliadasTarjetaDebitoResponse1/ns0:consultaCuentasAfiliadasTarjetaDebitoResponseType/ns0:consultaCuentasAfiliadasTarjetaDebitoResponseRecordType
        return 
         <result>
         {
           for $x in $cuenta
            where $x/ACCOUNT_RANK = "MAIN" and $x/CURRENCY = "HNL"
           return
    			$x/ACCOUNT_NUMBER
    			}
    	</result>
        
};

declare variable $consultaCuentasAfiliadasTarjetaDebitoResponse1 as element(ns0:consultaCuentasAfiliadasTarjetaDebitoResponse) external;

xf:ValidaCuentaPrincipal($consultaCuentasAfiliadasTarjetaDebitoResponse1)