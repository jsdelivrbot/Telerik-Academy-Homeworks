﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace GetWeekDay.Client.ServiceReferenceWeekDay {
    
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ServiceModel.ServiceContractAttribute(ConfigurationName="ServiceReferenceWeekDay.IServiceWeekDay")]
    public interface IServiceWeekDay {
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IServiceWeekDay/GetData", ReplyAction="http://tempuri.org/IServiceWeekDay/GetDataResponse")]
        string GetData(System.DateTime dateTime);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IServiceWeekDay/GetData", ReplyAction="http://tempuri.org/IServiceWeekDay/GetDataResponse")]
        System.Threading.Tasks.Task<string> GetDataAsync(System.DateTime dateTime);
    }
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public interface IServiceWeekDayChannel : GetWeekDay.Client.ServiceReferenceWeekDay.IServiceWeekDay, System.ServiceModel.IClientChannel {
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public partial class ServiceWeekDayClient : System.ServiceModel.ClientBase<GetWeekDay.Client.ServiceReferenceWeekDay.IServiceWeekDay>, GetWeekDay.Client.ServiceReferenceWeekDay.IServiceWeekDay {
        
        public ServiceWeekDayClient() {
        }
        
        public ServiceWeekDayClient(string endpointConfigurationName) : 
                base(endpointConfigurationName) {
        }
        
        public ServiceWeekDayClient(string endpointConfigurationName, string remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public ServiceWeekDayClient(string endpointConfigurationName, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public ServiceWeekDayClient(System.ServiceModel.Channels.Binding binding, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(binding, remoteAddress) {
        }
        
        public string GetData(System.DateTime dateTime) {
            return base.Channel.GetData(dateTime);
        }
        
        public System.Threading.Tasks.Task<string> GetDataAsync(System.DateTime dateTime) {
            return base.Channel.GetDataAsync(dateTime);
        }
    }
}
