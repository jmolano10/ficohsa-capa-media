(:: pragma bea:global-element-parameter parameter="$depositoefecenmonedaextranjera" element="ns0:Depositoefecenmonedaextranjera" location="../../xsds/Depositos/XMLSchema_-420276392.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$depositoefecenmonedaextranjeraResponse" element="ns0:DepositoefecenmonedaextranjeraResponse" location="../../xsds/Depositos/XMLSchema_-420276392.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadeusuariosdelsistema" location="../../xsds/Core/XMLSchema_1632682327.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/DepositoDeEfecEnMonExtranjera/ConsultaDeUsuariosDelSistemaIn/";

declare function xf:ConsultaDeUsuariosDelSistemaIn($depositoefecenmonedaextranjera as element(ns0:Depositoefecenmonedaextranjera),
    $depositoefecenmonedaextranjeraResponse as element(ns0:DepositoefecenmonedaextranjeraResponse))
    as element(ns0:Consultadeusuariosdelsistema) {
        <ns0:Consultadeusuariosdelsistema>
            {
                for $WebRequestCommon in $depositoefecenmonedaextranjera/WebRequestCommon
                return
                    <WebRequestCommon>{ $WebRequestCommon/@* , $WebRequestCommon/node() }</WebRequestCommon>
            }
            <WSUSERType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    {
                        for $AUTHORISER in $depositoefecenmonedaextranjeraResponse/TELLERType/AUTHORISER
                        return
                            <criteriaValue>{ fn:tokenize(data($AUTHORISER), "_")[2] }</criteriaValue>
                    }
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSUSERType>
        </ns0:Consultadeusuariosdelsistema>
};

declare variable $depositoefecenmonedaextranjera as element(ns0:Depositoefecenmonedaextranjera) external;
declare variable $depositoefecenmonedaextranjeraResponse as element(ns0:DepositoefecenmonedaextranjeraResponse) external;

xf:ConsultaDeUsuariosDelSistemaIn($depositoefecenmonedaextranjera,
    $depositoefecenmonedaextranjeraResponse)