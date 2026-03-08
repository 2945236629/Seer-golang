package com.robot.app.mapProcess
{
   import com.robot.app.panel.*;
   import com.robot.app.task.taskscollection.*;
   import com.robot.core.config.*;
   import com.robot.core.manager.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.*;
   import flash.display.*;
   import flash.events.*;
   import org.taomee.manager.*;
   
   public class MapProcess_698 extends BaseMapProcess
   {
      
      public function MapProcess_698()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1020,47);
         this.initAQBtn();
         this.btnLevel["saixiaoxiBtn"].visible = false;
         this.btnLevel["saixiaoxiBtn"].buttonMode = false;
         this.btnLevel["saixiaoxiBtn"].mouseChildren = false;
         this.btnLevel["saixiaoxiBtn"].mouseEnabled = false;
         this.conLevel["exchangeMC"].buttonMode = true;
         this.conLevel["exchangeMC"].addEventListener(MouseEvent.CLICK,this.exchangeClick);
         ToolTipManager.add(this.conLevel["exchangeMC"],"达人勋章兑换机");
         this.depthLevel["exchangeMC"].mouseEnabled = false;
         this.depthLevel["exchangeMC"].mouseChildren = false;
         this.conLevel["videoBtn"].addEventListener(MouseEvent.CLICK,this.onVideoShow);
         this.conLevel["door01"].addEventListener(MouseEvent.MOUSE_OVER,this.onOverHandler);
         this.conLevel["door01"].addEventListener(MouseEvent.MOUSE_OUT,this.onOutHandler);
         this.conLevel["door02"].addEventListener(MouseEvent.MOUSE_OVER,this.onOverHandler);
         this.conLevel["door02"].addEventListener(MouseEvent.MOUSE_OUT,this.onOutHandler);
         Task899.initForMap698(this);
         Task902.initForMap698(this);
         Task934.initForMap698(this);
         Task947.initForMap698(this);
         Task961.initForMap698(this);
         Task983.initForMap698(this);
         Task1221.initForMap698(this);
         Task994.init698(this);
         Task1061.initTaskForMap698(this);
         Task1227.initForMap698(this);
         Task951.initTaskForMap698(this);
         Task1278.initForMap698(this);
         Task836.initFor698(this);
         if(TasksManager.getTaskStatus(1160) == TasksManager.COMPLETE)
         {
            conLevel["task899mc"]["mika"].visible = true;
         }
         else if(TasksManager.getTaskStatus(1160) == TasksManager.UN_ACCEPT)
         {
            if(TasksManager.getTaskStatus(1144) == TasksManager.COMPLETE)
            {
               conLevel["task899mc"]["mika"].visible = false;
            }
            else if(TasksManager.getTaskStatus(1144) == TasksManager.ALR_ACCEPT)
            {
               TasksManager.getProStatusList(1144,function(param1:Array):void
               {
                  if(Boolean(param1[1]))
                  {
                     conLevel["task899mc"]["mika"].visible = false;
                  }
               });
            }
         }
         else
         {
            TasksManager.getProStatusList(1160,function(param1:Array):void
            {
               var a:Array = param1;
               if(Boolean(a[2]))
               {
                  conLevel["task899mc"]["mika"].visible = true;
               }
               else if(TasksManager.getTaskStatus(1144) == TasksManager.COMPLETE)
               {
                  conLevel["task899mc"]["mika"].visible = false;
               }
               else if(TasksManager.getTaskStatus(1144) == TasksManager.ALR_ACCEPT)
               {
                  TasksManager.getProStatusList(1144,function(param1:Array):void
                  {
                     if(Boolean(param1[1]))
                     {
                        conLevel["task899mc"]["mika"].visible = false;
                     }
                  });
               }
            });
         }
      }
      
      private function initAQBtn() : void
      {
         conLevel["startQSPanel"].addEventListener(MouseEvent.CLICK,VideoPanelMananger.instance.openQSubject);
         ToolTipManager.add(conLevel["startQSPanel"],"开始答题");
      }
      
      private function onVideoShow(param1:MouseEvent) : void
      {
         if(Boolean(param1))
         {
            SocketConnection.send(1020,48);
         }
         VideoPanelMananger.instance.openMainVideo();
      }
      
      private function onOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         _loc2_.gotoAndPlay(2);
      }
      
      private function onOutHandler(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         _loc2_.gotoAndStop(1);
      }
      
      private function exchangeClick(param1:MouseEvent) : void
      {
         SocketConnection.send(1020,49);
         ModuleManager.showModule(ClientConfig.getAppModule("ExchangePanel"),"正在打开面板...");
      }
      
      override public function destroy() : void
      {
         this.conLevel["videoBtn"].removeEventListener(MouseEvent.CLICK,this.onVideoShow);
         conLevel["startQSPanel"].removeEventListener(MouseEvent.CLICK,VideoPanelMananger.instance.openQSubject);
         ToolTipManager.remove(conLevel["startQSPanel"]);
         this.conLevel["exchangeMC"].removeEventListener(MouseEvent.CLICK,this.exchangeClick);
         ToolTipManager.remove(this.conLevel["exchangeMC"]);
         this.conLevel["door01"].removeEventListener(MouseEvent.MOUSE_OVER,this.onOverHandler);
         this.conLevel["door01"].removeEventListener(MouseEvent.MOUSE_OUT,this.onOutHandler);
         this.conLevel["door02"].removeEventListener(MouseEvent.MOUSE_OVER,this.onOverHandler);
         this.conLevel["door02"].removeEventListener(MouseEvent.MOUSE_OUT,this.onOutHandler);
         Task899.destroy();
         Task902.destroy();
         Task934.destroy();
         Task947.destroy();
         Task961.destroy();
         Task983.destroy();
         Task994.destroy();
         Task1061.destroy();
         Task1221.destroy();
         Task1227.destroy();
         Task951.destroy();
         VideoPanelMananger.instance.destroy();
      }
   }
}

