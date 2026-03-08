package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_3009;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   import org.taomee.manager.ResourceManager;
   
   public class MapProcess_10528 extends BaseMapProcess
   {
      
      public function MapProcess_10528()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         if(TasksManager.getTaskStatus(3009) == TasksManager.UN_ACCEPT)
         {
            TasksManager.accept(3009);
         }
         TasksManager.getProStatusList(3009,function(param1:Array):void
         {
            if(!param1[0])
            {
               pro1();
            }
            else if(!param1[1])
            {
               pro2();
            }
         });
      }
      
      private function pro1() : void
      {
         KTool.hideMapAllPlayerAndMonster();
         ResourceManager.getResource(ClientConfig.getMapAnimate("map_10528_0"),function(param1:MovieClip):void
         {
            var mod1:TaskMod;
            var mod2:TaskMod;
            var mod3:TaskMod;
            var mod4:TaskMod;
            var mod5:TaskMod;
            var mod6:TaskMod;
            var mod7:TaskMod;
            var mod8:TaskMod;
            var mod9:TaskMod;
            var taskMc:MovieClip = param1;
            MapManager.currentMap.controlLevel.addChild(taskMc);
            mod1 = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_3009_1",true]);
            mod2 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[taskMc,1,"mc1"]);
            mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.GAIYA,["我跟踪你这么久，就是要调查清楚你到底是谁！没想到，你果然是上古凶兽之一！"],["盖亚？"]);
            mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOGESI_YAOMO,["可恶！我只要得到阿萨斯的所有能量，就能够成为战无不胜的王者！为什么你们总是坏我的好事！"],["邪恶的家伙！"]);
            mod5 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.GAIYA,["传说中的上古凶兽竟然也需要假借别人的能量！哼！所谓的强大也不过如此嘛！"],["好大的口气！"]);
            mod6 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[taskMc,2,"mc2"]);
            mod7 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.GAIYA,["有我盖亚在的一天，我就绝对不允许你们这些邪恶的家伙得逞。"],["那就要看你的实力了！"]);
            mod8 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOLINGKING,["有我在的一天，我就绝对不允许你们战神联盟影响我称霸泰坦星系！哈哈哈！"],["可恶！"]);
            mod9 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[taskMc,3,"mc3"]);
            TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6,mod7,mod8,mod9],function():void
            {
               MapManager.currentMap.controlLevel.removeChild(taskMc);
               TaskController_3009.completeNode1(pro2);
            });
         });
      }
      
      private function pro2() : void
      {
         KTool.hideMapAllPlayerAndMonster();
         ResourceManager.getResource(ClientConfig.getMapAnimate("map_10528_1"),function(param1:MovieClip):void
         {
            var mod1:TaskMod;
            var mod2:TaskMod;
            var mod3:TaskMod;
            var mod4:TaskMod;
            var mod5:TaskMod;
            var mod6:TaskMod;
            var mod7:TaskMod;
            var mod8:TaskMod;
            var mod9:TaskMod;
            var mod10:TaskMod;
            var mod11:TaskMod;
            var mod12:TaskMod;
            var mod13:TaskMod;
            var taskMc:MovieClip = param1;
            MapManager.currentMap.controlLevel.addChild(taskMc);
            mod1 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOLINGKING,["哼！我以为是何方神圣！没想到是你这个丧家之犬！没了阿萨斯的庇护，你还敢来挑衅我！"],["我不会放过你！"]);
            mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.YELIMEISI_XIE,["我要让你血债血还！就算是拼劲全力，我也不会饶过你！"],["血债血还？"]);
            mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOLINGKING,["要不是为了保护你，他怎么会被我打得能量尽失，被奥斯卡囚禁在无间境地？"],["闭嘴！"]);
            mod4 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[taskMc,1,"mc1"]);
            mod5 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.GAIYA,["布莱克！你知道你在做什么吗？他是魔灵王？他是大魔头！你难道忘了我们战神联盟的使命了吗？"],["对呀！"]);
            mod6 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SEER,["布莱克，你忘记我们曾经一起打败邪灵组织吗？我们就是为了正义呀！"],["我自有安排！"]);
            mod7 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.BULAIKE_NEW,[MainManager.actorInfo.formatNick + "、盖亚，如果你当我是朋友，就请相信我！"],["可是……"]);
            mod8 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[taskMc,2,"mc2"]);
            mod9 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOGESI_YAOMO,["魔灵王，你有一位好侄儿呀！没想到战神联盟都唯你所用。"],["哈哈哈！"]);
            mod10 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOLINGKING,["布莱克，你不愧是我们魔灵一族的王者呀！回到我身边吧，我们一起称霸宇宙！ "],["闭嘴！"]);
            mod11 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.BULAIKE_NEW,["我只是不希望你被外人打败！我再劝你一次，放弃你的野心！"],["这个有点难！"]);
            mod12 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOLINGKING,["我做了这么多，除掉了索伦森、消灭了阿萨斯，如今有成功召唤上古凶兽，不就是为了成就霸业吗？ "],["一派胡言！"]);
            mod13 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[taskMc,3,"mc3"]);
            TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6,mod7,mod8,mod9,mod10,mod11,mod12,mod13],function():void
            {
               MapManager.currentMap.controlLevel.removeChild(taskMc);
               TaskController_3009.completeNode2();
            });
         });
      }
   }
}

