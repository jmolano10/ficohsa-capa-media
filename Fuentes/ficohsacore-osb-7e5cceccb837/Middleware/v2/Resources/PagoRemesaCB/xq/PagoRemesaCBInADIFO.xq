(:: pragma bea:local-element-parameter parameter="$ADDITIONAL_INFO" type="ns0:pagoRemesas/ADDITIONAL_INFO" location="../xsd/pagoRemesaCB.xsd" ::)
(:: pragma bea:global-element-return element="ns0:pagoRemesas" location="../xsd/pagoRemesaCB.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRemesasCBTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRemesaCB/xq/PagoRemesaCBInADIFO/";

declare function xf:PagoRemesaCBInADIFO($ADDITIONAL_INFO as element())
    as element(ns0:pagoRemesas) {
        <ns0:pagoRemesas>
            {
                let $ADDITIONAL_INFO := $ADDITIONAL_INFO
                return
                    <ADDITIONAL_INFO>
                        {
                            for $INFO in $ADDITIONAL_INFO/INFO
                            return
                                 <INFO>
                                
                                   {
                                        for $NAME in $INFO/NAME
                                        return
                                            <NAME>{ data($NAME) }</NAME>
                                    }
                                    {
                                        for $VALUE in $INFO/VALUE
                                        return
                                            <VALUE>{ data($VALUE) }</VALUE>
                                    }
                                
                                </INFO>
                        }
                    </ADDITIONAL_INFO>
            }
        </ns0:pagoRemesas>
};

declare variable $ADDITIONAL_INFO as element() external;

xf:PagoRemesaCBInADIFO($ADDITIONAL_INFO)
