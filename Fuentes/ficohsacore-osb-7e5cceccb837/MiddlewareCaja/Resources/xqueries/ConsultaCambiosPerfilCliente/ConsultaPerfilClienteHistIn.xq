(:: pragma bea:global-element-parameter parameter="$consultaperfildecliente" element="ns0:Consultaperfildecliente" location="../../xsds/ConsultaCambiosPerfilCliente/ConsultaCambiosPerfilCliente.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultaperfildeclientehist" location="../../xsds/PerfilCliente/XMLSchema_-994245660.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaCambiosPerfilCliente/ConsultaPerfilClienteHistIn/";

declare function xf:ConsultaPerfilClienteHistIn($consultaperfildecliente as element(ns0:Consultaperfildecliente),
    $currNo as xs:string)
    as element(ns0:Consultaperfildeclientehist) {
        <ns0:Consultaperfildeclientehist>
            {
                for $WebRequestCommon in $consultaperfildecliente/WebRequestCommon
                return
                    <WebRequestCommon>{ $WebRequestCommon/@* , $WebRequestCommon/node() }</WebRequestCommon>
            }
            <WSCUSTOMERFULLHISTType>
                <enquiryInputCollection>
                    {
                        for $columnName in $consultaperfildecliente/WSCUSTOMERFULLType/enquiryInputCollection[1]/columnName
                        return
                            <columnName>{ data($columnName) }</columnName>
                    }
                    {
                        for $criteriaValue in $consultaperfildecliente/WSCUSTOMERFULLType/enquiryInputCollection[1]/criteriaValue
                        return
                            <criteriaValue>{ concat($criteriaValue,";",fn-bea:fail-over(xs:int($currNo)-1, 1)) }</criteriaValue>
                    }
                    {
                        for $operand in $consultaperfildecliente/WSCUSTOMERFULLType/enquiryInputCollection[1]/operand
                        return
                            <operand>{ data($operand) }</operand>
                    }
                </enquiryInputCollection>
            </WSCUSTOMERFULLHISTType>
        </ns0:Consultaperfildeclientehist>
};

declare variable $consultaperfildecliente as element(ns0:Consultaperfildecliente) external;
declare variable $currNo as xs:string external;

xf:ConsultaPerfilClienteHistIn($consultaperfildecliente,
    $currNo)