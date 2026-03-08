package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_95;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import org.taomee.events.DynamicEvent;
   import org.taomee.manager.EventManager;
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcess_10025 extends BaseMapProcess
   {
      
      private var gains_0:MovieClip;
      
      private var gains_1:MovieClip;
      
      private var gains_2:MovieClip;
      
      private var gainsArr:Array = [];
      
      private var gainsCount:uint = 0;
      
      private var hitNoseMC:MovieClip;
      
      private var qishiMC:MovieClip;
      
      public function MapProcess_10025()
      {
         super();
      }
      
      override protected function init() : void
      {
         this.hitNoseMC = animatorLevel["hitNoseMC"];
         this.hitNoseMC.visible = false;
         this.gains_0 = conLevel["gains_0"];
         this.gains_1 = conLevel["gains_1"];
         this.gains_2 = conLevel["gains_2"];
         this.gainsArr = [this.gains_0,this.gains_1,this.gains_2];
         this.qishiMC = animatorLevel["qishiMC"];
         this.qishiMC.visible = false;
      }
      
      override public function destroy() : void
      {
      }
      
      private function initTask_95() : void
      {
         if(TasksManager.getTaskStatus(95) == TasksManager.COMPLETE)
         {
            this.qishiMC.visible = true;
            DisplayUtil.removeForParent(this.hitNoseMC);
            DisplayUtil.removeForParent(this.gains_0);
            DisplayUtil.removeForParent(this.gains_1);
            DisplayUtil.removeForParent(this.gains_2);
            return;
         }
         if(TasksManager.getTaskStatus(95) == TasksManager.ALR_ACCEPT)
         {
            TasksManager.getProStatusList(95,this.taskStatus);
         }
      }
      
      public function changeMap() : void
      {
         MapManager.changeLocalMap(323);
      }
      
      private function taskStatus(param1:Array) : void
      {
         var _loc2_:MovieClip = null;
         if(Boolean(param1[3]) && !param1[4])
         {
            for each(_loc2_ in this.gainsArr)
            {
               _loc2_.buttonMode = true;
               _loc2_.addEventListener(MouseEvent.CLICK,this.onClickGains);
            }
            EventManager.addEventListener("get_all_gains",this.getAllGains);
            if(!TaskController_95.isShow)
            {
               TaskController_95.showPanel();
            }
         }
         if(param1[5])
         {
            this.qishiMC.visible = true;
         }
      }
      
      private function onClickGains(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         _loc2_.buttonMode = false;
         _loc2_.removeEventListener(MouseEvent.CLICK,this.onClickGains);
         EventManager.dispatchEvent(new DynamicEvent("get_gains",_loc2_.name));
      }
      
      private function getAllGains(param1:Event) : void
      {
         var evt:Event = param1;
         EventManager.removeEventListener("get_all_gains",this.getAllGains);
         NpcDialog.show(NPC.LAMU,["你到底好了没有啊！骑士们貌似已经起疑心了！你伪装看看吧！不过我感觉你那个铁皮骗不了他们……"],["不管了！我试试再说！"],[function():void
         {
            TaskController_95.showTaskPanel(4);
            EventManager.addEventListener("taskPanel_4_close",showTaskPanelComp_4);
         }]);
      }
      
      private function showTaskPanelComp_4(param1:DynamicEvent) : void
      {
         var evt:DynamicEvent = param1;
         EventManager.removeEventListener("taskPanel_4_close",this.showTaskPanelComp_4);
         MainManager.actorModel.visible = false;
         this.hitNoseMC.visible = true;
         AnimateManager.playMcAnimate(this.hitNoseMC,0,"",function():void
         {
            NpcDialog.show(NPC.SEER,["哎呀！好疼！#2这下总可以了吧！再去试试看吧……"],["再拍下那个骑士看看反映？"],[function():void
            {
               MainManager.actorModel.visible = true;
               DisplayUtil.removeForParent(hitNoseMC);
               TasksManager.complete(95,4,null,true);
            }]);
         });
      }
   }
}

