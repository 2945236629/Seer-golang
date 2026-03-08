package com.robot.app.mapProcess
{
   import com.robot.app.control.*;
   import com.robot.app.energy.utils.*;
   import com.robot.app.ogre.*;
   import com.robot.app.task.control.*;
   import com.robot.app.task.taskscollection.*;
   import com.robot.core.animate.*;
   import com.robot.core.config.*;
   import com.robot.core.manager.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.*;
   import com.robot.core.npc.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import org.taomee.manager.*;
   import org.taomee.utils.*;
   
   public class MapProcess_688 extends BaseMapProcess
   {
      
      private var count:Dictionary = new Dictionary();
      
      private var timeOutID:uint;
      
      public function MapProcess_688()
      {
         super();
      }
      
      override protected function init() : void
      {
         if(TasksManager.getTaskStatus(TaskController_832.TASK_ID) == TasksManager.COMPLETE)
         {
            this.showRoadTo696();
         }
         else
         {
            conLevel["to696door"].mouseEnabled = false;
         }
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         NpcController.npcVisible = false;
         this.initDoor(conLevel["door_1"]);
         this.initDoor(conLevel["door_2"]);
         this.initDoor(conLevel["door_3"]);
         this.addToolTip(conLevel["door_1"]);
         this.addToolTip(conLevel["door_2"]);
         this.addToolTip(conLevel["door_3"]);
         conLevel["house_guide"].visible = false;
         conLevel["house_guide"].mouseEnabled = false;
         conLevel["door_guide"].visible = false;
         conLevel["door_guide"].mouseEnabled = false;
         conLevel["ruiersi"].gotoAndStop(1);
         conLevel["task810mc"].stop();
         conLevel["task810mc"].visible = false;
         topLevel["entryGuide"].visible = false;
         topLevel["entryGuide"].mouseEnabled = false;
         Task799.initForMap688(this);
         Task810.initForMap688(this);
         Task815.initForMap688(this);
         Task821.initForMap688(this);
         Task832.initForMap688(this);
         this.showRuiersi();
         OgreController.isShow = true;
         getDefinitionByName("com.robot.app2.mapProcess.control.activityControl.OreChaserDerossiController").initForMap688(this);
         MapListenerManager.add(depthLevel["checkup"] as SimpleButton,function():void
         {
            SocketConnection.send(1022,86056816);
            ProvPetController.showProcPanel();
         },"精灵鉴定台");
      }
      
      private function showRuiersi() : void
      {
         if(TasksManager.getTaskStatus(TaskController_832.TASK_ID) == TasksManager.ALR_ACCEPT)
         {
            TasksManager.getProStatusList(TaskController_832.TASK_ID,function(param1:Array):void
            {
               var a:Array = param1;
               if(Boolean(a[0]) && Boolean(a[1]) && Boolean(a[2]) && Boolean(a[3]) && Boolean(a[4]) && !a[5])
               {
                  DisplayUtil.removeForParent(conLevel["sptruiersi"]);
                  return;
               }
               AnimateManager.playMcAnimate(conLevel["sptruiersi"],1,"",function():void
               {
                  DisplayUtil.removeForParent(conLevel["sptruiersi"]);
                  NpcController.showNpc(112);
               });
            });
         }
         else
         {
            AnimateManager.playMcAnimate(conLevel["sptruiersi"],1,"",function():void
            {
               DisplayUtil.removeForParent(conLevel["sptruiersi"]);
               NpcController.showNpc(112);
            });
         }
      }
      
      public function showRoadTo696() : void
      {
         conLevel["to696door"].addEventListener(MouseEvent.CLICK,this.goto696);
         conLevel["to696door"].mouseEnabled = true;
         ToolTipManager.add(conLevel["to696door"],"结晶岩洞");
      }
      
      private function goto696(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         MainManager.actorModel.moveAndAction(new Point(570,165),function():void
         {
            AnimateManager.playFullScreenAnimate(ClientConfig.getFullMovie("task_832_"),function():void
            {
               MapManager.changeMap(696);
            });
         });
      }
      
      private function addToolTip(param1:MovieClip) : void
      {
         ToolTipManager.add(param1,"点击三次敲门");
         param1.buttonMode = true;
      }
      
      private function initDoor(param1:MovieClip) : void
      {
         param1.gotoAndStop(1);
         this.count[param1] = 0;
         param1.addEventListener(MouseEvent.CLICK,this.doorClicked);
      }
      
      private function doorClicked(param1:Event) : void
      {
         var reset:Function = null;
         var door:MovieClip = null;
         door = null;
         var e:Event = param1;
         door = MovieClip(e.currentTarget);
         ++this.count[door];
         if(this.count[door] == 3)
         {
            if(door == conLevel["door_1"])
            {
               door.buttonMode = false;
               door.removeEventListener(MouseEvent.CLICK,this.doorClicked);
               conLevel["door_guide"].visible = false;
               door.gotoAndStop(2);
               this.timeOutID = setTimeout(function():void
               {
                  door.visible = false;
                  NpcController.showNpc(107);
               },2000);
            }
            else if(door == conLevel["door_3"])
            {
               reset = function():void
               {
                  count[door] = 0;
               };
               if(Boolean(conLevel["task815mc"]))
               {
                  conLevel["task815mc"]["guide"].visible = false;
               }
               NpcDialog.show(NPC.XIAOLV,["妹妹门前一条弯弯的河。（你只有选对歌词，我才会开门哦！）"],["a．姐姐的笑容就像一支甜甜的歌。","b．哥哥对面唱着一支甜甜的歌。","哎呀，这首歌我不会唱啊！"],[function():void
               {
                  NpcDialog.show(NPC.XIAOLV,["选错歌词了噢，重新敲门吧！"]);
                  count[door] = 0;
               },function():void
               {
                  AnimateManager.playMcAnimate(door,2,"mc",function():void
                  {
                     door.buttonMode = false;
                     door.removeEventListener(MouseEvent.CLICK,doorClicked);
                     door.visible = false;
                     NpcController.showNpc(110);
                  });
               },reset]);
            }
            else
            {
               door.buttonMode = false;
               door.removeEventListener(MouseEvent.CLICK,this.doorClicked);
               NpcDialog.show(NPC.SEER,["？木有反应，这家好像没人哦，我去其它的房子看看。"]);
            }
         }
      }
      
      public function openDoorDandi() : void
      {
         var _loc1_:MovieClip = conLevel["door_1"];
         conLevel["door_guide"].visible = false;
         _loc1_.visible = false;
         NpcController.showNpc(107);
         _loc1_.buttonMode = false;
         _loc1_.removeEventListener(MouseEvent.CLICK,this.doorClicked);
      }
      
      public function exploitOre() : void
      {
         EnergyController.exploit(31);
      }
      
      public function exploitGas() : void
      {
         EnergyController.exploit(37);
      }
      
      override public function destroy() : void
      {
         var _loc1_:* = undefined;
         conLevel["to696door"].removeEventListener(MouseEvent.CLICK,this.goto696);
         Task799.destroy();
         Task810.destroy();
         Task815.destroy();
         Task821.destroy();
         Task832.destroy();
         clearTimeout(this.timeOutID);
         for(_loc1_ in this.count)
         {
            _loc1_.removeEventListener(MouseEvent.CLICK,this.doorClicked);
            delete this.count[_loc1_];
         }
         super.destroy();
      }
   }
}

