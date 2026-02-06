xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/ABK/consultaCuentaBeneficios/xsd/ConsultaCuentaBeneficios_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaCuentaBeneficiosResponse" location="../xsd/consultaCuentaBeneficiosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaCuentaBeneficiosTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaCuentaBeneficios";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCuentaBeneficios/xq/consultaCtaBeneficioOut/";

declare function xf:consultaCtaBeneficioOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultaCuentaBeneficiosResponse) {
        <ns0:consultaCuentaBeneficiosResponse>
            <ns0:benefitsList>
                <ns0:benefitItem>
                 	{
                        for $CODE in $outputParameters/ns1:PV_BENEFICIOS/ns1:PV_BENEFICIOS_ITEM[1]/ns1:CODE
                        return
                            <ns0:CODE>{ data(string($CODE)) }</ns0:CODE>
                    }
                    {
                        for $DESCRIPTION in $outputParameters/ns1:PV_BENEFICIOS/ns1:PV_BENEFICIOS_ITEM[1]/ns1:DESCRIPTION
                        return
                            <ns0:DESCRIPTION>{ data($DESCRIPTION) }</ns0:DESCRIPTION>
                    }
                </ns0:benefitItem>
            </ns0:benefitsList>
        </ns0:consultaCuentaBeneficiosResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;
declare variable $CUENTA as xs:string external;

xf:consultaCtaBeneficioOut($outputParameters)