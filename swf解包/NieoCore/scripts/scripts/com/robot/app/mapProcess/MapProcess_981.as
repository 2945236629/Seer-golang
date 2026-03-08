package com.robot.app.mapProcess
{
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.BitBuffSetClass;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_981 extends BaseMapProcess
   {
      
      private var npcMC:MovieClip;
      
      public function MapProcess_981()
      {
         super();
      }
      
      override protected function init() : void
      {
         getDefinitionByName("com.robot.app2.mapProcess.control.ThreeMainPetsEvolveTrainningController").initForMap(this);
         var _loc1_:Object = getDefinitionByName("com.robot.app2.mapProcess.control.ThreeMainPetsFeatureItemController");
         if(_loc1_.isOpen)
         {
            _loc1_.init();
            MapManager.currentMap.controlLevel.getChildByName("itemTips").visible = true;
         }
         else
         {
            MapManager.currentMap.controlLevel.getChildByName("itemTips").visible = false;
         }
         topLevel.mouseChildren = topLevel.mouseEnabled = false;
      }
      
      private function onNpcClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         var name:String = e.currentTarget.name;
         if(name == "mengnalisha")
         {
            StatManager.sendStat2014("三主宠进阶-蒙娜丽莎","和蒙娜丽莎对话",StatManager.RUN_ACT);
            NpcDialog.show(NPC.MENGNALISHA,["你准备好了要进阶我了吗，机智的赛尔？"],["是的，开始进阶吧蒙娜丽莎","我还没准备好呢"],[function():void
            {
               var mod1:* = undefined;
               if(!BitBuffSetClass.getState(22460))
               {
                  mod1 = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["active_20140613_3",true]);
                  TaskDiaLogManager.single.playStory([mod1],function():void
                  {
                     BitBuffSetClass.setState(22460,1);
                     ModuleManager.showModule(ClientConfig.getAppModule("GrassMainPetUpgradePanel"));
                  });
               }
               else
               {
                  ModuleManager.showModule(ClientConfig.getAppModule("GrassMainPetUpgradePanel"));
               }
            }]);
         }
         else if(name == "zhiyanjingang")
         {
            StatManager.sendStat2014("三主宠进阶-炽焰金刚","和炽焰金刚对话",StatManager.RUN_ACT);
            NpcDialog.show(NPC.CHIYANJINGANG,["你准备好了要进阶我了吗，机智的赛尔？"],["是的，开始进阶吧炽焰金刚","我还没准备好呢"],[function():void
            {
               var mod1:* = undefined;
               if(!BitBuffSetClass.getState(22470))
               {
                  mod1 = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["active_20140627_threeMainPet",true]);
                  TaskDiaLogManager.single.playStory([mod1],function():void
                  {
                     BitBuffSetClass.setState(22470,1);
                     ModuleManager.showModule(ClientConfig.getAppModule("FireMainPetUpgradePanel"));
                  });
               }
               else
               {
                  ModuleManager.showModule(ClientConfig.getAppModule("FireMainPetUpgradePanel"));
               }
            }]);
         }
         else if(name == "lizhualusiwang")
         {
            StatManager.sendStat2014("三主宠进阶-利爪鲁斯王","和利爪鲁斯王对话",StatManager.RUN_ACT);
            NpcDialog.show(NPC.LUSIWANG_ENVO,["你准备好了要进阶我了吗，机智的赛尔？"],["是的，开始进阶吧利爪鲁斯王","我还没准备好呢"],[function():void
            {
               var mod1:* = undefined;
               if(!BitBuffSetClass.getState(22461))
               {
                  mod1 = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["active_20140620_6",true]);
                  TaskDiaLogManager.single.playStory([mod1],function():void
                  {
                     BitBuffSetClass.setState(22461,1);
                     ModuleManager.showModule(ClientConfig.getAppModule("RiverMainPetUpgradePanel"));
                  });
               }
               else
               {
                  ModuleManager.showModule(ClientConfig.getAppModule("RiverMainPetUpgradePanel"));
               }
            }]);
         }
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.mapProcess.control.ThreeMainPetsEvolveTrainningController").destroy();
         getDefinitionByName("com.robot.app2.mapProcess.control.ThreeMainPetsFeatureItemController").destroy();
      }
   }
}

