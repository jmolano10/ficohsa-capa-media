(:: pragma bea:local-element-parameter parameter="$PRODUCTS" type="ns0:consultaProductoBeneficiosResponse/PRODUCTS" location="../xsd/consultaProductoBeneficiosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaProductoBeneficiosResponse" location="../xsd/consultaProductoBeneficiosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaProductoBeneficiosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaProductoBeneficio/xq/consultaProdBeneOut/";

declare function xf:consultaProdBeneOut($PRODUCTS as element())
    as element(ns0:consultaProductoBeneficiosResponse) {
        <ns0:consultaProductoBeneficiosResponse>
            {
                let $PRODUCTS := $PRODUCTS
                return
                    <PRODUCTS>
                        {
                            for $PRODUCT in $PRODUCTS/PRODUCT
                            return
                                <PRODUCT>
                                    {
                                        for $TYPE in $PRODUCT/TYPE
                                        return
                                            <TYPE>{ data($TYPE) }</TYPE>
                                    }
                                    {
                                        for $VALUE in $PRODUCT/VALUE
                                        return
                                            <VALUE>{ data($VALUE) }</VALUE>
                                    }
                                    {
                                        for $BENEFIT in $PRODUCT/BENEFIT
                                        return
                                            <BENEFIT>{ data($BENEFIT) }</BENEFIT>
                                    }
                                    {
                                        for $REGION in $PRODUCT/REGION
                                        return
                                            <REGION>{ data($REGION) }</REGION>
                                    }
                                    {
                                        for $APPLY_BENEFIT in $PRODUCT/APPLY_BENEFIT
                                        return
                                            <APPLY_BENEFIT>{ data($APPLY_BENEFIT) }</APPLY_BENEFIT>
                                    }
                                </PRODUCT>
                        }
                    </PRODUCTS>
            }
        </ns0:consultaProductoBeneficiosResponse>
};

declare variable $PRODUCTS as element() external;

xf:consultaProdBeneOut($PRODUCTS)